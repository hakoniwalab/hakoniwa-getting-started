# クイックスタート — Windows (WSL2)

このガイドでは、Windows + WSL2 環境で TurtleBot3 をゲームパッドで操作するまでの手順を説明します。  
操作はすべて WSL2 のターミナルから行います。

---

## 前提条件

- Windows 10 / 11
- WSL2 がインストール済みであること
- PS4 / PS5 コントローラ（USB または Bluetooth）

---

## Step 1: 箱庭コア機能のインストール（Windows）

hakowin のインストーラを使って、箱庭コア機能を Windows にインストールします。

→ [hakoCoreInstaller の手順](https://github.com/buildko89/documents/blob/main/hakodoc/wininstall-doc/coreinstall.md)

インストール後、WSL2 から箱庭コアのコマンドが使えることを確認してください。

---

## Step 2: このリポジトリを clone する

```bash
git clone --recursive https://github.com/hakoniwalab/hakoniwa-getting-started.git
cd hakoniwa-getting-started
```

`--recursive` を指定することで、以下のサブモジュールが同時に取得されます。

- `hakoniwa-mujoco-robots`
- `hakoniwa-godot`
- `hakoniwa-mbody-registry`

---

## Step 3: Python 環境のセットアップ

```bash
pip install hakoniwa-pdu
```

Python 3.12 を推奨します。

---

## Step 4: Godot のセットアップ（Windows native）

### 4-1. Godot v4.6.1 をダウンロード

[Godot 公式サイト](https://godotengine.org/) から **v4.6.1** をダウンロードしてください。

### 4-2. addons.zip を配置する

[hakoniwa-godot のリリースページ](https://github.com/hakoniwalab/hakoniwa-godot/releases) から  
**Windows 用の addons.zip** をダウンロードし、以下のディレクトリに解凍します。

```text
hakoniwa-getting-started/
└── godot/
    └── tb3-viewer-template/   ← ここに解凍する
        ├── addons/            ← addons.zip の中身
        └── ...
```

### 4-3. Godot でプロジェクトを開く

Godot を起動し、`godot/tb3-viewer-template/project.godot` を開きます。

---

## Step 5: hakoniwa-mujoco-robots のバイナリを配置する

[hakoniwa-getting-started のリリースページ](https://github.com/hakoniwalab/hakoniwa-getting-started/releases) から  
**Windows 用の mujoco-robots.zip** をダウンロードし、以下のディレクトリに解凍します。

```text
hakoniwa-getting-started/
└── hakoniwa-mujoco-robots/   ← ここに解凍する
```

> 💡 自分でビルドしたい方は [option-build-from-source.md](./option-build-from-source.md) を参照してください。

---

## Step 6: シミュレーションを起動する

以下の順番で起動します。

### 6-1. 箱庭コアを起動

```bash
# WSL2 から
（コマンド準備中）
```

### 6-2. TurtleBot3 シミュレーションを起動

```bash
# WSL2 から
（コマンド準備中）
```

### 6-3. Godot シーンを起動

Godot の再生ボタンを押してシーンを起動します。

---

## Step 7: ゲームパッドで操作する

```bash
# WSL2 から
（コマンド準備中）
```

ゲームパッドのスティックを動かすと、Godot 上の TurtleBot3 が動きます。  
LiDAR のスキャン結果も画面上で確認できます。

---

## うまくいかない場合

- Godot が起動しない → addons.zip の配置場所を確認してください
- ロボットが動かない → 箱庭コアが起動しているか確認してください
- ゲームパッドが反応しない → コントローラの接続を確認してください

---

## 次のステップ

チュートリアルが完了したら、次のことに挑戦できます。

- [自分のロボットを追加する](./add-your-robot.md)（hakoniwa-mbody-registry を使う）
- [ソースからビルドする](./option-build-from-source.md)（開発者向け）
- [ドローンシミュレーションを試す](https://github.com/toppers/hakoniwa-drone-core)