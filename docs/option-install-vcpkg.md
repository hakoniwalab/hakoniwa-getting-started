# 開発環境のセットアップ — vcpkg / GLFW / Boost（Windows）

このドキュメントでは、Windows native 環境で箱庭関連プロジェクトをソースからビルドするために必要な、vcpkg・GLFW・Boost のセットアップ手順を説明します。

> 💡 ビルド不要でまず動かしたい方は [quick-start-win.md](./quick-start-win.md) を参照してください。

---

## 1. 前提条件

事前に次のツールをインストールしておいてください。

| ツール | 用途 |
|---|---|
| Git | vcpkg の取得に使用します |
| Visual Studio 2022 / Build Tools | C++ ライブラリのビルドに使用します |
| CMake | C/C++ プロジェクトのビルド設定に使用します |
| Python 3.12 | Python バインディングのビルドに使用します |

Visual Studio を使う場合は、インストーラで次のワークロードを有効にしてください。

- C++ によるデスクトップ開発
- Windows SDK
- CMake tools for Windows

---

## 2. vcpkg のインストール

この手順では、例として次の場所に vcpkg をインストールします。

```powershell
C:\project\vcpkg
```

別の場所にインストールしても構いません。その場合は、以降の `C:\project\vcpkg` を自分の環境に合わせて読み替えてください。

### 2-1. vcpkg を取得する

```powershell
cd C:\project
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg
.\bootstrap-vcpkg.bat
```

成功すると `vcpkg.exe` が作成されます。

```powershell
.\vcpkg.exe version
```

バージョン情報が表示されれば OK です。

### 2-2. 環境変数を設定する

現在開いている PowerShell だけで使う場合：

```powershell
$env:VCPKG_ROOT = "C:\project\vcpkg"
$env:Path += ";$env:VCPKG_ROOT"
```

毎回設定したくない場合は、ユーザー環境変数として保存します：

```powershell
setx VCPKG_ROOT "C:\project\vcpkg"
setx PATH "$env:PATH;C:\project\vcpkg"
```

> Note: `setx` で設定した環境変数は、現在開いている PowerShell には反映されません。新しい PowerShell を開き直してください。

---

## 3. GLFW をインストールする

箱庭の MuJoCo viewer で OpenGL window を使うために必要です。

```powershell
cd C:\project\vcpkg
.\vcpkg.exe install glfw3:x64-windows
```

---

## 4. Boost をインストールする

Boost をまとめてインストールします：

```powershell
cd C:\project\vcpkg
.\vcpkg.exe install boost:x64-windows
```

> Note: Boost 全体のインストールは時間がかかります。特に hakoniwa-pdu-endpoint では `boost-asio` と `boost-beast` が必要になることが多いです。個別にインストールする場合：
>
> ```powershell
> .\vcpkg.exe install boost-asio:x64-windows
> .\vcpkg.exe install boost-beast:x64-windows
> .\vcpkg.exe install boost-filesystem:x64-windows
> .\vcpkg.exe install boost-system:x64-windows
> .\vcpkg.exe install boost-program-options:x64-windows
> ```

インストール済みパッケージの確認：

```powershell
.\vcpkg.exe list
```

`glfw3:x64-windows` や `boost:x64-windows` が表示されれば OK です。

---

## 5. CMake から vcpkg を使う

CMake でビルドするときは、vcpkg の toolchain file を指定します：

```powershell
cmake -B build -S . `
  -DCMAKE_TOOLCHAIN_FILE=C:/project/vcpkg/scripts/buildsystems/vcpkg.cmake
```

`VCPKG_ROOT` を設定している場合：

```powershell
cmake -B build -S . `
  -DCMAKE_TOOLCHAIN_FILE="$env:VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
```

---

## 6. 次のステップ

依存ライブラリのセットアップが完了したら、実際のビルド手順は以下を参照してください。

- `hakoniwa-godot` addons と `hakoniwa-mujoco-robots` TB3 のビルド
  - [option-build-from-source.md](./option-build-from-source.md)

---

## Tips: よくある詰まりポイント

### x64-windows を統一する

箱庭 Getting Started では 64bit Windows を前提にします。vcpkg の triplet は必ず `x64-windows` を使ってください。`x86-windows` と混在するとリンクエラーになります。

### 既存の build ディレクトリが残っている

```
generator platform: x64 ... used previously
```

というエラーが出た場合は、既存の build ディレクトリを削除してから再実行してください。

```powershell
Remove-Item -Recurse -Force build-win
```

### `setx` 後は PowerShell を開き直す

`setx` で環境変数を設定した後は、新しい PowerShell を開き直してください。既に開いている PowerShell には反映されません。

### `BoostConfig.cmake` が見つからない

vcpkg で Boost をインストール済みか確認し、CMake 実行時に `-DCMAKE_TOOLCHAIN_FILE` で vcpkg の toolchain file を必ず指定してください。

---

## 参考情報

- [vcpkg 公式リポジトリ](https://github.com/microsoft/vcpkg)
- [vcpkg ドキュメント](https://learn.microsoft.com/vcpkg/)
- [hakoniwa-mujoco-robots](https://github.com/hakoniwalab/hakoniwa-mujoco-robots)
