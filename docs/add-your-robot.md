# 自分のロボットを追加する — xacro から Godot まで

このドキュメントでは、TurtleBot3（TB3）を例に、xacro ファイルから Godot で動かせるアセット一式を生成する手順を説明します。

> 💡 この手順は `hakoniwa-mbody-registry` を使います。`hakoniwa-getting-started` をリポジトリを `--recursive` で clone 済みであれば、すでに手元にあります。

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

TB3 の場合は、upstream から sparse fetch します。

```bash
python3 tools/fetch.py sources/tb3.yaml
```

取得先：`bodies/turtlebot3/source/`

---

## Step 2: xacro → plain URDF

```bash
python3 tools/xacro2urdf.py \
  bodies/turtlebot3/source/turtlebot3_description/urdf/turtlebot3_burger.urdf
```

出力：`bodies/turtlebot3/generated/turtlebot3_burger.urdf`

---

## Step 3: URDF → MJCF

```bash
python3 tools/urdf2mjcf.py \
  bodies/turtlebot3/generated/turtlebot3_burger.urdf
```

出力：`bodies/turtlebot3/generated/turtlebot3_burger.xml`

---

## Step 4: アクチュエータを追加する

`bodies/turtlebot3/config/actuators.yaml` を使ってアクチュエータ定義を追加します。

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

Godot 用に、ボディごとに分割した GLB ファイルを生成します。

```bash
python3 tools/urdf2glb.py \
    bodies/turtlebot3/source/turtlebot3_burger.urdf \
    --parts-dir bodies/turtlebot3/generated/parts
```

出力：`bodies/turtlebot3/generated/parts/*.glb`

---

## Step 6: PDU 定義を生成する

`bodies/turtlebot3/config/pdu-manifest.yaml` から PDU 定義を生成します。

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

```bash
python3 tools/hako_viewer_model_gen.py \
  bodies/turtlebot3/config/viewer.recipe.yaml \
  -o bodies/turtlebot3/view/turtlebot3.json \
  --pretty
```

### 7-2. Godot シーン (.tscn) を生成する

```bash
python3 tools/hako_godot_scene_gen.py \
  bodies/turtlebot3/view/turtlebot3.json \
  -o bodies/turtlebot3/godot_tb3_reference/TurtleBot3.generated.tscn \
  --res-root res:// \
  --sync-script tb3_reference_sync.gd
```

### 7-3. Godot endpoint 設定を生成する

```bash
python3 tools/godot_sync2endpoint.py \
  bodies/turtlebot3/config/godot_sync.yaml
```

### 7-4. robot sync profile を生成する

```bash
python3 tools/godot_sync2profile.py \
  bodies/turtlebot3/config/godot_sync.yaml \
  bodies/turtlebot3/view/turtlebot3.json
```

---

## Step 8: Godot プロジェクトへ配置する

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