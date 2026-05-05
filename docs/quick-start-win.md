# クイックスタート — Windows (WSL2)

このガイドでは、Windows + WSL2 環境で TurtleBot3 をゲームパッドで操作するまでの手順を説明します。  
はじめての方でも迷いにくいように、まずは **最短ルート** で動かすことを目指します。

---

## この QuickStart で使う実行環境

この QuickStart では、**Windows** と **WSL2** を役割分担して使います。

- **Windows PowerShell**
  - 箱庭コア機能の確認
  - Python 環境のセットアップ
  - `HAKO_CONFIG_PATH` や `PYTHONPATH` の確認
- **WSL2**
  - リポジトリの clone
  - `tb3-demo.bash` の実行
  - 起動スクリプトやログ確認
- **Windows native 側で動くもの**
  - Godot
  - MuJoCo のウィンドウ
  - `hakopy` を使う Python 実行環境

つまり、**WSL2 は主に起動スクリプト操作に使い、実際のシミュレーション画面や Windows 向け Python 連携は Windows native 側で動きます。**

---

## 前提条件

- Windows 10 / 11
- WSL2 がインストール済みであること
- PS4 / PS5 コントローラ（USB または Bluetooth）がパソコンに接続されていること

---

## Step 1: 箱庭コア機能のインストール（Windows）

hakowin のインストーラを使って、箱庭コア機能を Windows にインストールします。

→ [Windows版箱庭コア機能のインストール手順](https://github.com/buildko89/hakowin)

### インストールチェック内容

インストール後、PowerShell と WSL2 の両方で、環境変数と実体を確認してください。

#### 1-1. `PATH` の確認

Windows PowerShell から箱庭コアのコマンドが使えることを確認してください。

> 🛑 **【重要】ここは Windows PowerShell で実行！**

```powershell
hako-cmd.exe
```

```text
Hakoniwa command-line tool
Usage:
  hako-cmd [command] [options] positional parameters

  -h, --help     Print usage
  -v, --version  Print version
```

`hako-cmd.exe` が起動できない場合は、`PATH` が正しく通っていない可能性があります。

#### 1-2. `HAKO_CONFIG_PATH` の確認

PowerShell で `HAKO_CONFIG_PATH` の値を確認し、実際にその場所に `cpp_core_config.json` が存在することを確認してください。

> 🛑 **【重要】ここは Windows PowerShell で実行！**

```powershell
$env:HAKO_CONFIG_PATH
Test-Path $env:HAKO_CONFIG_PATH
```

#### 1-3. Python / `PYTHONPATH` の確認

> 🛑 **【重要】ここは Windows PowerShell で実行！**

また、Python 3.12 であることを確認してください。

```powershell
python --version
Python 3.12.3
```

> 🛑 **【重要】ここは Windows PowerShell で実行！**

`PYTHONPATH` に箱庭コアの Python バインディングが含まれていることも確認してください。

```powershell
$env:PYTHONPATH
```

特に重要なのは、`hakopy` が import できることです。

```powershell
python -c "import hakopy; print(hakopy.__file__)"
```

`import hakopy` が成功し、`hakopy.pyd` の場所が表示されれば OK です。

---

## Step 2: このリポジトリを clone する

本チュートリアルでは、Cドライブ直下に project ディレクトリを作り、その中にリポジトリを clone することを推奨します。

WSL2で、以下のコマンドを順番に実行してください。

> 🛑 **【重要】ここは WSL2 で実行！**

```bash
cd /mnt/c
mkdir project
cd project
git clone --recursive https://github.com/hakoniwalab/hakoniwa-getting-started.git
cd hakoniwa-getting-started
```

`--recursive` を指定することで、以下のサブモジュールが同時に取得されます。

- `hakoniwa-mujoco-robots`
- `hakoniwa-godot`
- `hakoniwa-mbody-registry`

---

## Step 3: Python 環境のセットアップ

> 🛑 **【重要】ここは Windows PowerShell で実行！**

PowerShell で、まず Python のバージョンを確認してください。

```powershell
python --version
python -m pip --version
```

`Python 3.12.x` と表示されれば OK です。

次に、`pip` がどの Python に紐づいているかを確認します。

そのうえで、`hakoniwa-getting-started` ディレクトリに移動し、次のコマンドを実行して Python 環境をセットアップします。

```powershell
cd C:\project\hakoniwa-getting-started
python -m pip install -r hakoniwa-mbody-registry/requirements.txt
```

> 💡 既存の Python 環境を汚したくない場合は、必要に応じて venv を使っても構いません。ただし、この QuickStart では必須ではありません。

---

## Step 4: Godot のセットアップ（Windows native）

### 4-1. Godot をダウンロード

[Godot 公式サイト](https://godotengine.org/) から v4.6.1 以降をダウンロードしてください。

※ 2026/5/3 時点で、v4.6.1 / v4.6.2 の動作を確認しています。

### 4-2. addons.zip を配置する

[hakoniwa-godot のリリースページ](https://github.com/hakoniwalab/hakoniwa-godot/releases) から  
**Windows 用の addons-win.zip** をダウンロードし、最終的に `godot/tb3-viewer-template/addons/` が存在するように配置します。

```text
hakoniwa-getting-started/
└── godot/
    └── tb3-viewer-template/   ← ここに解凍する
        ├── addons/            ← addons-win.zip の中身
        └── ...
```

zip を展開したときに余計な親ディレクトリが入る場合でも、**最終的に `godot/tb3-viewer-template/addons/` が見えていれば OK** です。

たとえば、次のように確認できます。

> 🛑 **【重要】ここは WSL2 で実行！**

```bash
ls godot/tb3-viewer-template
ls godot/tb3-viewer-template/addons
```

### 4-3. Godot でプロジェクトを開く

Godot を起動し、`godot/tb3-viewer-template/project.godot` を開きます。

成功すると、Godot のエディタ画面が表示されます。

![Godot Editor](/docs/images/godot-editor-opened.png)

この画面が開けたら、いったんそのまま待機しておいて大丈夫です。

---

## Step 5: hakoniwa-mujoco-robots のバイナリを配置する

[hakoniwa-mujoco-robots のリリースページ](https://github.com/hakoniwalab/hakoniwa-mujoco-robots/releases) から  
**Windows 用の tb3_bin-win.zip** をダウンロードし、最終的に `hakoniwa-mujoco-robots/tb3_bin-win/tb3_sim.exe` が存在するように配置します。

```text
hakoniwa-getting-started/
└── hakoniwa-mujoco-robots/   ← ここに解凍する
```

解凍後、`hakoniwa-getting-started/hakoniwa-mujoco-robots/tb3_bin-win` ディレクトリに、少なくとも次のファイルがあることを確認してください。

> 🛑 **【重要】ここは WSL2 で実行！**

```bash
ls hakoniwa-mujoco-robots/tb3_bin-win
```

特に、次のファイルが同じディレクトリにあることを確認してください。

- `tb3_sim.exe`
- `mujoco.dll`
- `glfw3.dll`

> 💡 自分でビルドしたい方は [option-build-from-source.md](./option-build-from-source.md) を参照してください。

---

## Step 6: まず MuJoCo 側だけで起動確認する

最初の確認では、いきなり Godot を再生しないでください。まずは MuJoCo 側のロボットが単体で正常に起動するかを確認します。

WSL2上で、以下の順番で起動します。

### 6-1. TurtleBot3 シミュレーションを起動

TB3シミュレーション実行ディレクトリへ移動します。

> 🛑 **【重要】ここは WSL2 で実行！**

```bash
# hakoniwa-getting-started ディレクトリから実行してください
cd hakoniwa-mujoco-robots
```

TB3シミュレーションを起動します。

```bash
bash tb3-demo.bash
```

成功すると、MuJoCoのウィンドウが表示されます。

※ゲームパッド、LiDARビジュアライザー、箱庭コア機能、コンダクター等も同時に起動されます。

この段階では、まず MuJoCo 側のロボットが落ちずに起動するかを確認してください。

### 6-2. 起動に失敗した場合はログを確認する

ロボットがすぐ落ちる場合は、`hakoniwa-mujoco-robots/logs` 配下のログを確認してください。

```text
hakoniwa-mujoco-robots/logs/
```

`tb3-demo.bash` は `tb3-demo-launch-win.json` を使って asset を起動しており、各ログ名はその `assets.name` に対応します。

たとえば、現在の設定では次のような対応です。

- `tb3_sim` → `logs/tb3_sim.out`, `logs/tb3_sim.err`
- `gamepad` → `logs/gamepad.out`, `logs/gamepad.err`
- `lidar` → `logs/lidar.out`, `logs/lidar.err`

issue を報告する場合は、どの asset が落ちたかと、その `*.err` / `*.out` の内容を添えてください。

`tb3-demo-launch-win.json` の `assets.name` を読むと、どのログがどのプロセスに対応するか確認できます。

## Step 7: Godot シーンを起動

Step 6 で MuJoCo 単体の起動確認ができたら、いったん `Ctrl+C` で終了して構いません。

最終的な統合確認では、もう一度 `bash tb3-demo.bash` を起動し、MuJoCo のウィンドウが表示された直後に Godot の再生ボタンを押してください。

Godot の再生ボタンを押してシーンを起動します。

> ⚠️ **注意: MuJoCo のウィンドウが表示された直後に、Godot の再生ボタンを押してください。**
>
> **ここがいちばん大事です。**
> すべて起動し終わってから Godot を再生すると、連携のタイミングに間に合わず失敗することがあります。

うまくいかなかった場合は、いったんターミナルで `Ctrl+C` を押して終了し、もう一度 `bash tb3-demo.bash` からやり直してください。

### Godot の起動タイミングに注意

箱庭コア機能はシミュレーション基盤です。Launcher は `before_start` の asset をすべて起動し終えると、箱庭シミュレーションを自動で開始します。

そのため、Godot はそのタイミングに間に合うように起動する必要があります。すべてが起動し終わった後で Godot を動かすと、参加タイミングが遅れて失敗することがあります。

「まず MuJoCo 側だけで起動確認する」のは切り分けのためですが、最終的な統合確認では MuJoCo ウィンドウが出た直後に Godot を再生してください。

---

## 参考: 完成イメージ動画

最終的にうまく連携できると、`tb3-demo.bash` で起動した TurtleBot3 が Godot 上でこのように描画されます。

[![TurtleBot3 demo video](https://img.youtube.com/vi/sCWhi5JLmdE/0.jpg)](https://www.youtube.com/watch?v=sCWhi5JLmdE)

> YouTube: https://www.youtube.com/watch?v=sCWhi5JLmdE

---

## Step 8: ゲームパッドで操作する

ゲームパッドのスティックを動かすと、Godot 上の TurtleBot3 が動きます。  
LiDAR のスキャン結果も画面上で確認できます。

- 左スティック：
  - 左右：旋回
- 右スティック：
  - 上下：前進 / 後退

---

## うまくいかない場合

- `hako-cmd.exe` が起動しない
  - `PATH` を確認してください
- `import hakopy` が失敗する
  - `PYTHONPATH` と `python --version`、`python -m pip --version` を確認してください
- Godot が起動しない
  - `godot/tb3-viewer-template/addons/` が正しく配置されているか確認してください
- MuJoCo が起動しない
  - `hakoniwa-mujoco-robots/tb3_bin-win/tb3_sim.exe`、`mujoco.dll`、`glfw3.dll` があるか確認してください
- Godot の再生が間に合わず失敗する
  - [Step 7「Godot の起動タイミングに注意」](#godot-の起動タイミングに注意)を参照し、`Ctrl+C` で止めてから `bash tb3-demo.bash` でやり直してください
- ロボットがすぐ落ちる
  - `hakoniwa-mujoco-robots/logs` に出た `*.out` / `*.err` を確認してください
  - issue を報告する場合は、その `*.out` / `*.err` の内容を添えてください
- ゲームパッドが反応しない
  - コントローラの接続を確認してください

### 終了方法

通常は、ターミナルで `Ctrl+C` を押すと関連プロセスが終了します。
残ったウィンドウがある場合は、個別に閉じてください。

---

## 高度な設定

### RAMDISK を使わずにセットアップしたい場合

通常はインストーラの標準設定のままで進めてください。ここは、事情があって RAMDISK を使わない場合の設定です。

Cドライブ直下に `project` ディレクトリを作成し、その中に `mmap` ディレクトリを作成してください。

```text
C:\project
└── mmap
```

そのうえで、`cpp_core_config.json` の `core_mmap_path` を `C:\project\mmap` に変更してください。

```json
{
    "shm_type": "mmap",
    "core_mmap_path": "C:\\project\\mmap",
    "asset_timeout_usec": 600000000
}
```

正常にインストールできている場合、`HAKO_CONFIG_PATH` は通常、次の場所を指します。

```text
C:\Users\<ユーザ名>\AppData\Roaming\hakocore-win\config\cpp_core_config.json
```

---

## Tips

### 箱庭 Launcher の仕組み

`tb3-demo.bash` から呼ばれる箱庭 Launcher は、launch JSON に書かれた asset を上から順番に起動するシンプルな仕組みです。

何が起動されているか、どの順番で起動されるか、どの asset 名でログが出るかを確認したい場合は、次のファイルを読んでください。

```text
hakoniwa-mujoco-robots/tb3-demo-launch-win.json
```

この JSON では、各 asset の `name`、`command`、`args`、`activation_timing` が定義されています。

---

## 既存ユーザ向け注意

過去のセットアップで使っていた端末や PowerShell を開きっぱなしにしていると、古い環境変数を掴んだままになることがあります。

新規セットアップでは、通常この対応は不要です。

- `PATH`
- `HAKO_CONFIG_PATH`
- `PYTHONPATH`

インストーラ再実行後や設定変更後は、新しい端末を開き直してから確認してください。

また、既存ユーザ環境では `mmap` ディレクトリ配下に古いメタデータが残り、箱庭コア機能の非互換変更後に起動不整合を起こすことがあります。既存ユーザで起動がおかしい場合は、トラブルシュートとして `core_mmap_path` が指すディレクトリ配下の古いファイル削除を検討してください。

---

## 次のステップ

チュートリアルが完了したら、次のことに挑戦できます。

- [自分のロボットを追加する](./add-your-robot.md)（hakoniwa-mbody-registry を使う）
- [ソースからビルドする](./option-build-from-source.md)（開発者向け）
