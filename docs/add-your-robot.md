# 自分のロボットを追加する — xacro から Godot まで

このドキュメントでは、TurtleBot3（TB3）を例に、xacro ファイルから Godot で動かせるアセット一式を生成する手順を説明します。

> 💡 この手順は `hakoniwa-mbody-registry` を使います。`hakoniwa-getting-started` を `--recursive` で clone 済みであれば、すでに手元にあります。

---

## はじめに

このドキュメントのステップ数は多めです。これは意図的です。

箱庭はロボットの種類や構成に応じて、異なるツールを組み合わせてシミュレーション資産を生成します。各ステップを細かく刻んであるのは、どのステップが何を変換しているかを明示し、将来的な自動化やカスタマイズの足がかりにするためです。現時点では、このフローはまだ試行段階にあります。

各ステップには「なぜこれが必要か」を添えています。一度通しで動かした後、自分のロボットに合わせてカスタマイズする際の参考にしてください。

---

## 全体フロー

```text
xacro / URDF
    ↓ xacro2urdf.py
plain URDF
    ↓ urdf2mjcf.py
MJCF (MuJoCo XML)
    ↓ mjcf_add_actuators.py
actuated MJCF
    ↓ mjcf2glb.py
parts/*.glb
    ↓ hako_viewer_model_gen.py
viewer model JSON
    ↓ hako_godot_scene_gen.py       ↓ godot_sync2profile.py
Godot .tscn                    robot_sync.profile.json
    ↓ godot_sync2endpoint.py
endpoint_shm_with_pdu.json
```

PDU 定義の生成：

```text
pdu-manifest.yaml
    ↓ pdu_manifest2types.py
pdutypes.json
    ↓ pdu_manifest2def.py
pdu_def.json
```

---

## 前提条件

```bash
cd /mnt/c/project/hakoniwa-getting-started/hakoniwa-mbody-registry
pip install -r requirements.txt
```

---

## Step 1: ロボット定義を取得する

**なぜ？** ROS 環境なしで upstream のロボット定義ファイルを取得するためです。`fetch.py` は sparse checkout を使って必要なファイルだけを取得します。ROS をインストールしなくても、GitHub 上の URDF / xacro ファイルを直接取得できます。

```bash
python3 tools/fetch.py sources/tb3.yaml
```

取得先：`bodies/turtlebot3/source/`

`sources/tb3.yaml` には、どのリポジトリのどのパスを取得するかが定義されています。自分のロボットを追加する場合は、このファイルを参考に新しい YAML を作成します。

---

## Step 2: xacro → plain URDF

**なぜ？** xacro は ROS のマクロ言語であり、そのままでは他のツールが読めません。`xacro2urdf.py` は ROS なしで xacro を展開し、標準的な plain URDF に変換します。これにより、下流の変換ツールが URDF を入力として扱えるようになります。

```bash
python3 tools/xacro2urdf.py \
  bodies/turtlebot3/source/turtlebot3_description/urdf/turtlebot3_burger.urdf
```

出力：`bodies/turtlebot3/generated/turtlebot3_burger.urdf`

---

## Step 3: URDF → MJCF

**なぜ？** MuJoCo は独自の XML フォーマット（MJCF）を使います。`urdf2mjcf.py` は MuJoCo の公式コンパイラを使って URDF を MJCF に変換します。MJCF は MuJoCo の高精度な剛体物理演算の入力となります。URDF のままでは MuJoCo で動かせません。

```bash
python3 tools/urdf2mjcf.py \
  bodies/turtlebot3/generated/turtlebot3_burger.urdf
```

出力：`bodies/turtlebot3/generated/turtlebot3_burger.xml`

---

## Step 4: アクチュエータを追加する

**なぜ？** 標準の URDF / MJCF はロボットの形状と関節構造を定義しますが、モーターなどの制御入力（アクチュエータ）は含みません。`mjcf_add_actuators.py` は YAML で定義したアクチュエータを MJCF に追加します。これにより、MuJoCo からモーターへの制御入力が可能になります。

```bash
python3 tools/mjcf_add_actuators.py \
  bodies/turtlebot3/generated/turtlebot3_burger.xml \
  bodies/turtlebot3/config/actuators.yaml
```

出力：`bodies/turtlebot3/generated/turtlebot3_burger.actuated.xml`

`actuators.yaml` の例：

```yaml
actuators:
  - type: motor
    name: left_motor
    joint: wheel_left_joint
    ctrllimited: true
    ctrlrange: [-10, 10]
    gear: 1.0

  - type: motor
    name: right_motor
    joint: wheel_right_joint
    ctrllimited: true
    ctrlrange: [-10, 10]
    gear: 1.0
```

---

## Step 5: GLB アセットを生成する（パーツ分割）

**なぜ？** Godot でロボットの各パーツを個別に動かすには、ボディごとに分割された 3D アセットが必要です。`urdf2glb.py` は URDF のビジュアルジオメトリをボディ単位で GLB ファイルに変換します。Godot はこれらの GLB をシーン内で各関節ノードに割り当てて描画します。

```bash
python3 tools/urdf2glb.py \
  bodies/turtlebot3/source/turtlebot3_burger.urdf \
  --parts-dir bodies/turtlebot3/generated/parts
```

出力：`bodies/turtlebot3/generated/parts/*.glb`

---

## Step 6: PDU 定義を生成する

**なぜ？** 箱庭では、ノード間のデータ通信は PDU（Protocol Data Unit）という契約で定義されます。`pdu-manifest.yaml` は「このロボットがどんなデータを送受信するか」を 1 つのファイルで定義します。ここから Godot・MuJoCo・Python が共通して参照する PDU 型定義ファイルを生成します。ROS のメッセージ型をそのまま使えるので、ROS の資産を活かせます。

```bash
python3 tools/pdu_manifest2types.py \
  bodies/turtlebot3/config/pdu-manifest.yaml

python3 tools/pdu_manifest2def.py \
  bodies/turtlebot3/config/pdu-manifest.yaml
```

出力：
- `bodies/turtlebot3/generated/pdutypes.json`
- `bodies/turtlebot3/generated/pdu_def.json`

`pdu-manifest.yaml` の TB3 例：

```yaml
format: hako_pdu_manifest
version: 0.1

robot_name: TB3

bodies:
  base:
    pdu_name: base_link_pos
    pdu_type: geometry_msgs/Twist
    body_name: base_link
    channel_id: 1

  joints:
    pdu_name: joint_states
    pdu_type: sensor_msgs/JointState
    channel_id: 5
    joint_names:
      - wheel_left_joint
      - wheel_right_joint

sensors:
  - name: lidar
    pdu_name: laser_scan
    pdu_type: sensor_msgs/LaserScan
    channel_id: 3
    body_name: base_scan

extras:
  - name: game_controller_command
    pdu_name: hako_cmd_game
    pdu_type: hako_msgs/GameControllerOperation
    channel_id: 0
```

---

## Step 7: Godot 向けアセットを生成する

### 7-1. viewer model JSON を生成する

**なぜ？** Godot シーンを自動生成するには、ロボットの構造（どのボディがどの親子関係にあるか、どの GLB を使うか）を記述した中間データが必要です。`viewer.recipe.yaml` はその構造を定義し、`hako_viewer_model_gen.py` が MJCF と組み合わせて viewer model JSON を生成します。

```bash
python3 tools/hako_viewer_model_gen.py \
  bodies/turtlebot3/config/viewer.recipe.yaml \
  -o bodies/turtlebot3/view/turtlebot3.json \
  --pretty
```

### 7-2. Godot シーン (.tscn) を生成する

**なぜ？** Godot のシーンファイル（.tscn）を手書きするのは大変です。`hako_godot_scene_gen.py` は viewer model JSON から Godot が読めるシーンファイルを自動生成します。ロボットの構造が変わっても、このステップを再実行するだけでシーンを更新できます。

```bash
python3 tools/hako_godot_scene_gen.py \
  bodies/turtlebot3/view/turtlebot3.json \
  -o bodies/turtlebot3/godot_tb3_reference/TurtleBot3.generated.tscn \
  --res-root res:// \
  --sync-script tb3_reference_sync.gd
```

### 7-3. Godot endpoint 設定を生成する

**なぜ？** Godot が箱庭の共有メモリ（PDU）を読み書きするには、どの PDU チャンネルをどの通信方式で扱うかを設定したエンドポイント設定ファイルが必要です。`godot_sync.yaml` の定義からこの設定を自動生成します。

```bash
python3 tools/godot_sync2endpoint.py \
  bodies/turtlebot3/config/godot_sync.yaml
```

### 7-4. robot sync profile を生成する

**なぜ？** Godot のシーン内でロボットの各ノードを PDU データと紐づけるには、「このノードはこの PDU チャンネルのこのフィールドに対応する」というマッピングが必要です。`robot_sync.profile.json` がその役割を担います。

```bash
python3 tools/godot_sync2profile.py \
  bodies/turtlebot3/config/godot_sync.yaml \
  bodies/turtlebot3/view/turtlebot3.json
```

---

## Step 8: Godot プロジェクトへ配置する

**なぜ？** 生成したアセットを Godot プロジェクトの所定の場所に配置することで、Godot がシーン起動時にこれらを読み込めるようになります。

```bash
export GODOT_PROJECT_DIR=/mnt/c/project/hakoniwa-getting-started/godot/tb3-viewer-template

mkdir -p "$GODOT_PROJECT_DIR/parts"
mkdir -p "$GODOT_PROJECT_DIR/config"

cp -f bodies/turtlebot3/generated/parts/*.glb \
  "$GODOT_PROJECT_DIR/parts/"

cp -f bodies/turtlebot3/godot_tb3_reference/TurtleBot3.generated.tscn \
  "$GODOT_PROJECT_DIR/"

cp -f bodies/turtlebot3/godot_tb3_reference/tb3_reference_sync.gd \
  "$GODOT_PROJECT_DIR/"

cp -f bodies/turtlebot3/generated/endpoint_shm_with_pdu.json \
  "$GODOT_PROJECT_DIR/config/"

cp -f bodies/turtlebot3/generated/godot/robot_sync.profile.json \
  "$GODOT_PROJECT_DIR/config/"
```

---

## 生成物の一覧

| ファイル | 用途 |
|---|---|
| `generated/turtlebot3_burger.urdf` | plain URDF |
| `generated/turtlebot3_burger.xml` | MuJoCo XML |
| `generated/turtlebot3_burger.actuated.xml` | アクチュエータ付き MuJoCo XML |
| `generated/parts/*.glb` | Godot 用パーツ分割 GLB |
| `generated/pdutypes.json` | 箱庭 PDU 型定義 |
| `generated/pdu_def.json` | 箱庭 PDU コンパクト定義 |
| `generated/endpoint_shm_with_pdu.json` | Godot 用 endpoint 設定 |
| `generated/godot/robot_sync.profile.json` | Godot robot sync profile |
| `godot_tb3_reference/TurtleBot3.generated.tscn` | Godot シーン |

---

## 参考情報

- [hakoniwa-mbody-registry](https://github.com/hakoniwalab/hakoniwa-mbody-registry)
- [hakoniwa-godot](https://github.com/hakoniwalab/hakoniwa-godot)