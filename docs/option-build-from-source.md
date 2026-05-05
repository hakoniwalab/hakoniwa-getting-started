# ソースからビルドする（開発者向け）— Windows

このドキュメントでは、以下のコンポーネントをソースからビルドする手順を説明します。

- **hakoniwa-godot addons**（Godot 用 GDExtension）
- **hakoniwa-mujoco-robots TB3**（MuJoCo TurtleBot3 シミュレータ）

> 💡 ビルド不要でまず動かしたい方は [quick-start-win.md](./quick-start-win.md) を参照してください。

---

## 前提条件

vcpkg / GLFW / Boost のセットアップが完了していること。

→ [vcpkg・GLFW・Boost のインストール手順](./option-install-vcpkg.md)

---

## 1. hakoniwa-godot addons のビルド

### 1-1. 前提条件

addons のビルドは、WSL2上で、powershell.exe を呼び出す形で行います。以下のツールが必要です。
| ツール | バージョン |
|---|---|
| Visual Studio 2022 / Build Tools | C++ デスクトップ開発 |
| CMake | 3.16 以上 |
| vcpkg | セットアップ済み |
| Boost | vcpkg でインストール済み |

### 1-2. ビルド手順

```bash
cd /mnt/c/project/hakoniwa-getting-started/hakoniwa-godot
```

```bash
bash tools/build_all_codecs_wsl.sh
```

時間かかりますので、気長に待ちましょう。(体感で約１０分程度)

成功すると、addons 配下に以下のdllファイルが生成されます。

```bash
find addons -name "*.dll"
addons/hakoniwa/bin/libhakoniwa_godot_native.dll
addons/hakoniwa/codecs/ev3_msgs_codec.dll
addons/hakoniwa/codecs/hako_msgs_codec.dll
addons/hakoniwa/codecs/nav_msgs_codec.dll
addons/hakoniwa/codecs/hako_mavlink2_msgs_codec.dll
addons/hakoniwa/codecs/geometry_msgs_codec.dll
addons/hakoniwa/codecs/tf2_msgs_codec.dll
addons/hakoniwa/codecs/can_msgs_codec.dll
addons/hakoniwa/codecs/mavros_msgs_codec.dll
addons/hakoniwa/codecs/drone_srv_msgs_codec.dll
addons/hakoniwa/codecs/builtin_interfaces_codec.dll
addons/hakoniwa/codecs/hako_mavlink_msgs_codec.dll
addons/hakoniwa/codecs/std_msgs_codec.dll
addons/hakoniwa/codecs/sensor_msgs_codec.dll
addons/hakoniwa/codecs/hako_srv_msgs_codec.dll
```

### 1-3. 生成物の配置

ビルド成功後、生成された addons を以下に配置します。

```text
godot/tb3-viewer-template/
└── addons/   ← 生成物をここに配置
```

一括コピー：

```bash
cp -rp addons /mnt/c/project/hakoniwa-getting-started/godot/tb3-viewer-template/
```

---

## 2. hakoniwa-mujoco-robots TB3 のビルド

### 2-1. 前提条件

| ツール | バージョン |
|---|---|
| Visual Studio 2022 / Build Tools | C++ デスクトップ開発 |
| CMake | 3.16 以上 |
| vcpkg | セットアップ済み |
| GLFW | vcpkg でインストール済み |
| Boost | vcpkg でインストール済み |
| MuJoCo | v3.8.0 |

### 2-2. ビルド手順

WSL2 から PowerShell スクリプトを実行します。

```bash
cd /mnt/c/project/hakoniwa-getting-started/hakoniwa-mujoco-robots
```

```bash
bash build-win.bash
```

時間かかりますので、気長に待ちましょう。(体感で約１０分程度)

### 2-3. 生成物の確認

成功すると、`build-win/main_for_sample/tb3/Release/` 直下に、以下のファイルが生成されます。

```text
glfw3.dll
mujoco.dll
tb3_sim.exe
tb3_sim.exp
tb3_sim.lib
```

ビルド成功後、`tb3_bin-win` ディレクトリを作成し、対象バイナリを配置してください。

```bash
mkdir -p tb3_bin-win
cp build-win/main_for_sample/tb3/Release/glfw3.dll tb3_bin-win/
cp build-win/main_for_sample/tb3/Release/mujoco.dll tb3_bin-win/
cp build-win/main_for_sample/tb3/Release/tb3_sim.exe tb3_bin-win/
cp build-win/main_for_sample/tb3/Release/tb3_sim.exp tb3_bin-win/
cp build-win/main_for_sample/tb3/Release/tb3_sim.lib tb3_bin-win/
```

```text
hakoniwa-mujoco-robots/
└── tb3_bin-win/
    ├── glfw3.dll
    ├── mujoco.dll
    ├── tb3_sim.exe
    ├── tb3_sim.exp
    └── tb3_sim.lib
```

---

## Tips: よくある詰まりポイント

→ [vcpkg 関連の詰まりポイント](./option-install-vcpkg.md#tips-よくある詰まりポイント)

---

## 参考情報

- [hakoniwa-godot](https://github.com/hakoniwalab/hakoniwa-godot)
- [hakoniwa-mujoco-robots](https://github.com/hakoniwalab/hakoniwa-mujoco-robots)