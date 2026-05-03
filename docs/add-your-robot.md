# 自分のロボットを追加する — xacro から Godot まで

このドキュメントでは、TurtleBot3（TB3）を例に、xacro ファイルから Godot で動かせるアセット一式を生成する手順を説明します。

TB3 の再現に留まらず、**自分のロボットへ置き換えるための実用ガイド**として活用してください。

> 💡 この手順は `hakoniwa-mbody-registry` を使います。`hakoniwa-getting-started` を `--recursive` で clone 済みであれば、すでに手元にあります。

---

## はじめに

このドキュメントのステップ数は多めです。これは意図的です。

箱庭はロボットの種類や構成に応じて、異なるツールを組み合わせてシミュレーション資産を生成します。各ステップを細かく刻んであるのは、どのステップが何を変換しているかを明示し、将来的な自動化やカスタマイズの足がかりにするためです。

現時点では、このフローはまだ試行段階にあります。

各ステップには「なぜこれが必要か」と「自分のロボットではどこを変えるか」を添えています。一度 TB3 で通しで動かした後、自分のロボットに合わせてカスタマイズする際の参考にしてください。

---

## 設計思想

### なぜ Godot に直接変換しないのか

このフローでは、xacro から Godot シーンへ「直接変換」しません。必ず viewer model JSON という中間モデルを経由します。

これは意図的な設計です。

Godot に直接変換すると、Godot のバージョンが変わったり、別のゲームエンジンに移行したりするたびに、ロボットの定義から全部作り直しになります。

中間モデルを挟むことで、ユーザーは「ロボットの構造」だけを記述すればよく、ゲームエンジンへの変換はツール側が担います。

ユーザーの記述量を最小化し、ゲームエンジン非依存を実現するための構造です。

### なぜこれだけ複雑なプロセスが必要なのか

箱庭は「分散シミュレーション」というアーキテクチャを採用しています。MuJoCo・Godot・Python は別々のプロセスとして動き、PDU と時刻同期によって繋がります。

それぞれが独立して動くからこそ、各コンポーネント向けの変換ステップが必要になります。

この複雑さはアーキテクチャ上の必然ですが、各ステップを分離しているため、どこを差し替えればよいかが明確になります。つまり、複雑さを隠すのではなく、制御可能な単位に分解しています。

### これによって何が得られるか

このアプローチの本質的なメリットは、**特定ベンダへの依存からの脱却**です。

- Godot が変わっても、中間モデルを変換するツールを差し替えるだけでよい
- MuJoCo の代わりに別の物理エンジンを使いたければ、PDU 契約を守るだけでよい
- 新しいコンポーネントは「差し替え」ではなく「追加」として繋げられる

これは **水平統合への道筋** です。

箱庭はゲームエンジンでも物理エンジンでもなく、それらを繋げるインフラです。特定ベンダに縛られず、必要なコンポーネントを組み合わせて分散シミュレーション環境を構築できます。

---

## 全体フロー

```text
xacro / URDF
    ↓ xacro2urdf.py
plain URDF
    ├─ urdf2mjcf.py → MJCF → mjcf_add_actuators.py → actuated MJCF
    └─ urdf2glb.py  → parts/*.glb

MJCF / parts/*.glb / viewer.recipe.yaml
    ↓ hako_viewer_model_gen.py
viewer model JSON
    ├─ hako_godot_scene_gen.py → Godot .tscn
    └─ godot_sync2profile.py   → robot_sync.profile.json

godot_sync.yaml
    ↓ godot_sync2endpoint.py
endpoint_shm_with_pdu.json
```

PDU 定義の生成は、上記のフローと並行して実施します。

```text
pdu-manifest.yaml
    ├─ pdu_manifest2types.py → pdutypes.json
    └─ pdu_manifest2def.py   → pdu_def.json
```

---

## 前提条件

```bash
cd /mnt/c/project/hakoniwa-getting-started/hakoniwa-mbody-registry
pip install -r requirements.txt
```

---

## Step 1: ロボット定義を取得する

**なぜ？**
ROS 環境なしで upstream のロボット定義ファイルを取得するためです。

`fetch.py` は sparse checkout を使って必要なファイルだけを取得します。ROS をインストールしなくても、GitHub 上の URDF / xacro ファイルを直接取得できます。

```bash
python3 tools/fetch.py sources/tb3.yaml
```

取得先：

```text
bodies/turtlebot3/source/
```

> **自分のロボットでは：**
> `sources/tb3.yaml` をコピーし、取得元リポジトリ・branch・取得対象パスを自分のロボットに合わせて変更します。

---

## Step 2: xacro → plain URDF

**なぜ？**
xacro は ROS のマクロ言語であり、そのままでは他のツールが読めません。

`xacro2urdf.py` は ROS なしで xacro を展開し、標準的な plain URDF に変換します。これにより、下流の変換ツールが URDF を入力として扱えるようになります。

```bash
python3 tools/xacro2urdf.py \
  bodies/turtlebot3/source/turtlebot3_description/urdf/turtlebot3_burger.urdf
```

出力：

```text
bodies/turtlebot3/generated/turtlebot3_burger.urdf
```

> **自分のロボットでは：**
> 入力パスを自分のロボットの xacro / URDF ファイルに変更します。出力はツールの規約に従い `bodies/{name}/generated/` 以下に生成されます。

---

## Step 3: URDF → MJCF

**なぜ？**
MuJoCo は独自の XML フォーマット（MJCF）を使います。

`urdf2mjcf.py` は MuJoCo の公式コンパイラを使って URDF を MJCF に変換します。MJCF は MuJoCo の高精度な剛体物理演算の入力となります。URDF のままでは MuJoCo で動かせません。

```bash
python3 tools/urdf2mjcf.py \
  bodies/turtlebot3/generated/turtlebot3_burger.urdf
```

出力：

```text
bodies/turtlebot3/generated/turtlebot3_burger.xml
```

> **自分のロボットでは：**
> Step 2 で生成した URDF のパスに変更します。

---

## Step 4: アクチュエータを追加する

**なぜ？**
標準の URDF / MJCF はロボットの形状と関節構造を定義しますが、モーターなどの制御入力（アクチュエータ）は含みません。

`mjcf_add_actuators.py` は YAML で定義したアクチュエータを MJCF に追加します。これにより、MuJoCo からモーターへの制御入力が可能になります。

```bash
python3 tools/mjcf_add_actuators.py \
  bodies/turtlebot3/generated/turtlebot3_burger.xml \
  bodies/turtlebot3/config/actuators.yaml
```

出力：

```text
bodies/turtlebot3/generated/turtlebot3_burger.actuated.xml
```

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

> **自分のロボットでは：**
> 制御したい joint 名に合わせて `actuators.yaml` を作成します。joint 名は Step 3 で生成した MJCF 内の joint 名と一致している必要があります。

---

## Step 5: GLB アセットを生成する（パーツ分割）

**なぜ？**
Godot でロボットの各パーツを個別に動かすには、ボディごとに分割された 3D アセットが必要です。

`urdf2glb.py` は URDF のビジュアルジオメトリをボディ単位で GLB ファイルに変換します。Godot はこれらの GLB をシーン内で各関節ノードに割り当てて描画します。

```bash
python3 tools/urdf2glb.py \
  bodies/turtlebot3/generated/turtlebot3_burger.urdf \
  --parts-dir bodies/turtlebot3/generated/parts
```

出力：

```text
bodies/turtlebot3/generated/parts/*.glb
```

> **自分のロボットでは：**
> Step 2 で生成した plain URDF のパスに変更します。`--parts-dir` の出力先も `bodies/{name}/generated/parts` に揃えてください。

---

## Step 6: PDU 定義を生成する

**なぜ？**
箱庭では、ノード間のデータ通信は PDU（Protocol Data Unit）という契約で定義されます。

`pdu-manifest.yaml` は「このロボットがどんなデータを送受信するか」を 1 つのファイルで定義します。ここから Godot・MuJoCo・Python が共通して参照する PDU 型定義ファイルを生成します。

ROS のメッセージ型をそのまま使えるので、ROS の資産を活かせます。

```bash
python3 tools/pdu_manifest2types.py \
  bodies/turtlebot3/config/pdu-manifest.yaml

python3 tools/pdu_manifest2def.py \
  bodies/turtlebot3/config/pdu-manifest.yaml
```

出力：

```text
bodies/turtlebot3/generated/pdutypes.json
bodies/turtlebot3/generated/pdu_def.json
```

> 出力先はツールの規約に従い、`bodies/turtlebot3/generated/` 以下に生成されます。

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

> **自分のロボットでは：**
> publish / subscribe したいデータに合わせて `bodies` / `sensors` / `extras` を定義します。`channel_id` はロボット全体で一意になるよう注意してください。

---

## Step 7: Godot 向けアセットを生成する

Godot 向けには、主に以下の 3 種類の成果物を生成します。

* Godot シーン
* robot sync profile
* Godot endpoint 設定

Godot シーンと robot sync profile は viewer model JSON に依存します。そのため、まず 7-1 で viewer model JSON を生成します。

一方、Godot endpoint 設定は `godot_sync.yaml` から生成されます。

### 7-1. viewer model JSON を生成する

**なぜ？**
Godot シーンや robot sync profile を自動生成するには、ロボットの構造を記述した中間データが必要です。

この中間データには、どのボディがどの親子関係にあるか、どの GLB を使うか、といった情報が含まれます。

`viewer.recipe.yaml` はその構造を定義し、`hako_viewer_model_gen.py` が MJCF や GLB パーツ情報と組み合わせて viewer model JSON を生成します。

```bash
python3 tools/hako_viewer_model_gen.py \
  bodies/turtlebot3/config/viewer.recipe.yaml \
  -o bodies/turtlebot3/view/turtlebot3.json \
  --pretty
```

出力：

```text
bodies/turtlebot3/view/turtlebot3.json
```

> **自分のロボットでは：**
> `viewer.recipe.yaml` をロボットのボディ構造・GLB パーツ名に合わせて変更します。

### 7-2. robot sync profile を生成する

**なぜ？**
Godot のシーン内でロボットの各ノードを PDU データと紐づけるには、「このノードはこの PDU チャンネルのこのフィールドに対応する」というマッピングが必要です。

`robot_sync.profile.json` がその役割を担います。

```bash
python3 tools/godot_sync2profile.py \
  bodies/turtlebot3/config/godot_sync.yaml \
  bodies/turtlebot3/view/turtlebot3.json
```

出力：

```text
bodies/turtlebot3/generated/godot/robot_sync.profile.json
```

> **自分のロボットでは：**
> `godot_sync.yaml` の PDU チャンネルと Godot ノード名を、自分のロボットの構造に合わせて変更します。

### 7-3. Godot endpoint 設定を生成する

**なぜ？**
Godot が箱庭の共有メモリ（PDU）を読み書きするには、どの PDU チャンネルをどの通信方式で扱うかを設定したエンドポイント設定ファイルが必要です。

`godot_sync.yaml` の定義からこの設定を自動生成します。

```bash
python3 tools/godot_sync2endpoint.py \
  bodies/turtlebot3/config/godot_sync.yaml
```

出力：

```text
bodies/turtlebot3/generated/endpoint_shm_with_pdu.json
```

> **自分のロボットでは：**
> `godot_sync.yaml` の PDU 名、channel_id、通信方式を自分のロボットに合わせて変更します。

### 7-4. Godot シーン (.tscn) を生成する

**なぜ？**
Godot のシーンファイル（.tscn）を手書きするのは大変です。

`hako_godot_scene_gen.py` は viewer model JSON から Godot が読めるシーンファイルを自動生成します。ロボットの構造が変わっても、このステップを再実行するだけでシーンを更新できます。

```bash
python3 tools/hako_godot_scene_gen.py \
  bodies/turtlebot3/view/turtlebot3.json \
  -o bodies/turtlebot3/godot_tb3_reference/TurtleBot3.generated.tscn \
  --res-root res:// \
  --sync-script tb3_reference_sync.gd
```

出力：

```text
bodies/turtlebot3/godot_tb3_reference/TurtleBot3.generated.tscn
```

> **自分のロボットでは：**
> 7-1 で生成した viewer model JSON を使います。`--sync-script` に指定するスクリプト名も、自分のロボット用の同期スクリプトに合わせて変更してください。

---

## Step 8: Godot プロジェクトへ配置する

**なぜ？**
生成したアセットを Godot プロジェクトの所定の場所に配置することで、Godot がシーン起動時にこれらを読み込めるようになります。

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

> **自分のロボットでは：**
> コピー元のパスを自分のロボット名に合わせて変更します。Godot プロジェクト側の配置先も、テンプレート構成に合わせて調整してください。

---

## 生成物の一覧

| ファイル                                            | 用途                       |
| ----------------------------------------------- | ------------------------ |
| `generated/turtlebot3_burger.urdf`              | plain URDF               |
| `generated/turtlebot3_burger.xml`               | MuJoCo XML               |
| `generated/turtlebot3_burger.actuated.xml`      | アクチュエータ付き MuJoCo XML     |
| `generated/parts/*.glb`                         | Godot 用パーツ分割 GLB         |
| `generated/pdutypes.json`                       | 箱庭 PDU 型定義               |
| `generated/pdu_def.json`                        | 箱庭 PDU コンパクト定義           |
| `generated/endpoint_shm_with_pdu.json`          | Godot 用 endpoint 設定      |
| `generated/godot/robot_sync.profile.json`       | Godot robot sync profile |
| `godot_tb3_reference/TurtleBot3.generated.tscn` | Godot シーン                |

---

## 動作確認

Godot プロジェクトを開き、以下を順番に確認してください。

* 生成された `TurtleBot3.generated.tscn` が Godot に読み込まれていること
* シーン内に `parts/*.glb` が割り当てられ、ロボットの形状が表示されること
* `config/endpoint_shm_with_pdu.json` が配置されていること
* `config/robot_sync.profile.json` が配置されていること
* シーン内に `tb3_reference_sync.gd` が設定されていること

箱庭側を起動して動作を確認します。

* MuJoCo 側を起動すると、Godot 上の TurtleBot3 が動き始めること
* base pose と wheel joint が PDU 経由で更新されていること
* LiDAR のスキャン結果が可視化されること

---

## よくあるトラブル

### GLB が表示されない

以下を確認してください。

* `parts/*.glb` が Godot プロジェクトの `parts/` ディレクトリにコピーされているか
* Godot シーンに `WorldEnvironment` と `DirectionalLight3D` が含まれているか
* GLB に material が含まれているか
* `--res-root` の指定と Godot 側のリソースパスが一致しているか

問題が続く場合は、`urdf2glb.py --debug-colors` を使って、マテリアルなしで形状だけ確認してください。

### ロボットは表示されるが動かない

以下を確認してください。

* `endpoint_shm_with_pdu.json` の `channel_id` が `pdu-manifest.yaml` の定義と一致しているか
* `robot_sync.profile.json` の node path が Godot シーン内のノード名と一致しているか
* MuJoCo 側が `joint_states` / `base_link_pos` を PDU 経由で publish しているか
* 箱庭コアが起動しているか

箱庭コアの状態確認コマンドは環境によって異なります。たとえば Windows では次のように確認します。

```bash
hako-cmd.exe status
```

Linux / macOS では次のように確認します。

```bash
hako-cmd status
```

### MJCF の変換でエラーが出る

以下を確認してください。

* `urdf2mjcf.py` の入力が plain URDF、つまり Step 2 の出力であること
* xacro を直接 `urdf2mjcf.py` に渡していないこと
* `package://` 参照が残っている場合は、必要に応じて package root を指定して解決すること
* 参照先の mesh ファイルが取得済みであること

### PDU は出ているが Godot 側に反映されない

以下を確認してください。

* `pdu-manifest.yaml` と `godot_sync.yaml` の PDU 名が一致しているか
* `channel_id` が重複していないか
* `robot_sync.profile.json` のフィールド名が実際の PDU 型定義と一致しているか
* Godot 側の endpoint 設定ファイルが最新の生成物に置き換わっているか

---

## 参考情報

* [hakoniwa-mbody-registry](https://github.com/hakoniwalab/hakoniwa-mbody-registry)
* [hakoniwa-godot](https://github.com/hakoniwalab/hakoniwa-godot)
