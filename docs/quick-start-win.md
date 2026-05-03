# クイックスタート — Windows (WSL2)

このガイドでは、Windows + WSL2 環境で TurtleBot3 をゲームパッドで操作するまでの手順を説明します。  
操作はすべて WSL2 のターミナルから行います。

---

## 前提条件

- Windows 10 / 11
- WSL2 がインストール済みであること
- PS4 / PS5 コントローラ（USB または Bluetooth）がパソコンに接続されていること

---

## Step 1: 箱庭コア機能のインストール（Windows）

hakowin のインストーラを使って、箱庭コア機能を Windows にインストールします。

→ [Windows版箱庭コア機能のインストール手順](https://github.com/buildko89/hakowin)

なお、本インストールでは、RAMDISK を利用しない方法でセットアップすることも可能です。

その場合は、Cドライブ直下に project ディレクトリを作成し、mmap ディレクトリをその中に作成してください。

```text
C:\project
└── mmap
```

そして、`cpp_core_config.json` の `core_mmap_path` を `C:\project\mmap` に変更してください。

```json
cpp_core_config.json 
{
    "shm_type": "mmap",
    "core_mmap_path": "C:¥¥project¥¥mmap",
    "asset_timeout_usec": 600000000
}
```

`cpp_core_config.json` の場所は、環境変数 `HAKO_CONFIG_PATH` で確認できます。

```powershell
$env:HAKO_CONFIG_PATH
```

### インストールチェック内容

インストール後、WSL2 から箱庭コアのコマンドが使えることを確認してください。

```powershell
hako-cmd.exe
```

```bash
Hakoniwa command-line tool
Usage:
  hako-cmd [command] [options] positional parameters

  -h, --help     Print usage
  -v, --version  Print version
```

また、Python 3.12 であることを確認してください。

```bash
python --version
Python 3.12.3
```

`PYTHONPATH` に箱庭コアの Python バインディングが含まれていることも確認してください。

```powershell
$env:PYTHONPATH
```

---

## Step 2: このリポジトリを clone する

本チュートリアルでは、Cドライブ直下に project ディレクトリを作り、その中にリポジトリを clone することを推奨します。

WSL2で、以下のコマンドを順番に実行してください。

```bash
cd /mnt/c
```
```bash
mkdir project
```
```bash
cd project
```

```bash
git clone --recursive https://github.com/hakoniwalab/hakoniwa-getting-started.git
```
```bash
cd hakoniwa-getting-started
```

`--recursive` を指定することで、以下のサブモジュールが同時に取得されます。

- `hakoniwa-mujoco-robots`
- `hakoniwa-godot`
- `hakoniwa-mbody-registry`

---

## Step 3: Python 環境のセットアップ

PowerShell で hakoniwa-getting-started ディレクトリに移動し、次のコマンドを実行して Python 環境をセットアップします。

```powershell
pip install -r hakoniwa-mbody-registry/requirements.txt 
```

---

## Step 4: Godot のセットアップ（Windows native）

### 4-1. Godot v4.6.1 をダウンロード

[Godot 公式サイト](https://godotengine.org/) から **v4.6.1** をダウンロードしてください。

※ 2026/5/3 時点で、v4.6.2 でも動作することを確認しています。

### 4-2. addons.zip を配置する

[hakoniwa-godot のリリースページ](https://github.com/hakoniwalab/hakoniwa-godot/releases) から  
**Windows 用の addons-win.zip** をダウンロードし、以下のディレクトリに解凍します。

```text
hakoniwa-getting-started/
└── godot/
    └── tb3-viewer-template/   ← ここに解凍する
        ├── addons/            ← addons-win.zip の中身
        └── ...
```

### 4-3. Godot でプロジェクトを開く

Godot を起動し、`godot/tb3-viewer-template/project.godot` を開きます。

成功すると、Godot のエディタ画面が表示されます。

![Godot Editor](/docs/images/godot-editor-opened.png)

---

## Step 5: hakoniwa-mujoco-robots のバイナリを配置する

[hakoniwa-mujoco-robots のリリースページ](https://github.com/hakoniwalab/hakoniwa-mujoco-robots/releases) から  
**Windows 用の tb3_bin-win.zip** をダウンロードし、以下のディレクトリに解凍します。

```text
hakoniwa-getting-started/
└── hakoniwa-mujoco-robots/   ← ここに解凍する
```

解凍後、`hakoniwa-getting-started/hakoniwa-mujoco-robots/tb3_bin-win` ディレクトリに次のファイルがあることを確認してください。
```bash
tree hakoniwa-mujoco-robots/tb3_bin-win
hakoniwa-mujoco-robots/tb3_bin-win
├── glfw3.dll
├── mujoco.dll
├── tb3_sim.exe
├── tb3_sim.exp
└── tb3_sim.lib
```

> 💡 自分でビルドしたい方は [option-build-from-source.md](./option-build-from-source.md) を参照してください。

---

## Step 6: シミュレーションを起動する

WSL2上で、以下の順番で起動します。

### 6-1. TurtleBot3 シミュレーションを起動

TB3シミュレーション実行ディレクトリへ移動します。

```bash
cd hakoniwa-mujoco-robots
```

TB3シミュレーションを起動します。

```bash
bash tb3_demo.bash
```

成功すると、MuJoCoのウィンドウが表示されます。

※ゲームパッド、LiDARビジュアライザー、箱庭コア機能、コンダクター等も同時に起動されます。


### 6-2. Godot シーンを起動

Godot の再生ボタンを押してシーンを起動します。

※ MuJoCo のウィンドウが表示された直後に Godot の再生ボタンを押下してください。

---

## Step 7: ゲームパッドで操作する

ゲームパッドのスティックを動かすと、Godot 上の TurtleBot3 が動きます。  
LiDAR のスキャン結果も画面上で確認できます。

- 左スティック：
  - 左右：旋回
- 右スティック：
  - 上下：前進 / 後退

---

## うまくいかない場合

- Godot が起動しない → addons-win.zip の配置場所を確認してください
- ロボットが動かない → 箱庭コアが起動しているか確認してください
- ゲームパッドが反応しない → コントローラの接続を確認してください

---

## 次のステップ

チュートリアルが完了したら、次のことに挑戦できます。

- [自分のロボットを追加する](./add-your-robot.md)（hakoniwa-mbody-registry を使う）
- [ソースからビルドする](./option-build-from-source.md)（開発者向け）
