# ソースからビルドする（開発者向け）— Windows

このドキュメントでは、Windows native 環境で箱庭関連プロジェクトをソースからビルドするために必要な、vcpkg・GLFW・Boost・hakoniwa-pdu-endpoint のセットアップ手順を説明します。

> 💡 ビルド不要でまず動かしたい方は [quick-start.md](./quick-start-win.md) を参照してください。

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

## 6. hakoniwa-pdu-endpoint のビルド

### 6-1. C++ コアのビルド

```powershell
cmake -S . -B build-win `
  -DCMAKE_TOOLCHAIN_FILE=C:/project/vcpkg/scripts/buildsystems/vcpkg.cmake `
  -DVCPKG_TARGET_TRIPLET=x64-windows `
  -A x64
cmake --build build-win --config Release
```

### 6-2. Python バインディングのビルド

```powershell
python -m pip install --upgrade pip setuptools wheel cffi
.\build-python-win.ps1 `
  -BuildNative `
  -BuildFfi `
  -BuildDirName build-win `
  -Configuration Release `
  -PythonCommand python `
  -ToolchainFile C:\project\vcpkg\scripts\buildsystems\vcpkg.cmake `
  -VcpkgTriplet x64-windows `
  -Platform x64
```

インストール後の確認：

```powershell
python -c "from hakoniwa_pdu_endpoint import c_endpoint; print('import ok')"
```

### 6-3. prefix 配下にまとめてインストールする場合

```powershell
.\install-python-win.ps1 `
  -BuildFirst `
  -BuildDirName build-win `
  -Configuration Release `
  -PythonCommand python `
  -Prefix C:\hakoniwa `
  -ToolchainFile C:\project\vcpkg\scripts\buildsystems\vcpkg.cmake `
  -VcpkgTriplet x64-windows `
  -Platform x64
$env:PYTHONPATH="C:\hakoniwa\share\hakoniwa-pdu-endpoint\python;$env:PYTHONPATH"
```

---

## 7. hakoniwa-mujoco-robots のビルド

（手順準備中 — build.ps1 が確定次第追記します）

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

### Python: `cffi` と `_cffi_backend` の Version mismatch

ビルド時に別の Python 環境の `PYTHONPATH` が混入しています。ビルド時は `PYTHONPATH` を明示的に空にしてください。

### Python: `BoostConfig.cmake` が見つからない

vcpkg で `boost-asio:x64-windows` と `boost-beast:x64-windows` を入れ、`-ToolchainFile`・`-VcpkgTriplet`・`-Platform x64` を必ず渡してください。

### Python: 実行時に `hakoniwa_pdu_endpoint.dll` が見つからない

環境変数を設定してください：

```powershell
$env:HAKO_PDU_ENDPOINT_SHARED_LIB = "C:\hakoniwa\bin\hakoniwa_pdu_endpoint.dll"
```

または：

```powershell
$env:HAKO_PDU_ENDPOINT_LIB_DIR = "C:\hakoniwa\bin"
```

### Python: install 後も import できない

install 先を `PYTHONPATH` に追加してください：

```powershell
$env:PYTHONPATH="C:\hakoniwa\share\hakoniwa-pdu-endpoint\python;$env:PYTHONPATH"
```

---

## 参考情報

- [vcpkg 公式リポジトリ](https://github.com/microsoft/vcpkg)
- [vcpkg ドキュメント](https://learn.microsoft.com/vcpkg/)
- [hakoniwa-pdu-endpoint](https://github.com/hakoniwalab/hakoniwa-pdu-endpoint)
- [hakoniwa-mujoco-robots](https://github.com/hakoniwalab/hakoniwa-mujoco-robots)