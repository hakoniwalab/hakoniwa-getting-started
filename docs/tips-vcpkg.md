# Windows向け: vcpkg / GLFW / Boost インストール手順

このドキュメントでは、Windows native 環境で箱庭関連プロジェクトをビルドするために必要となる、vcpkg、GLFW、Boost のインストール手順を説明します。

> Note: 正式名称は `vcpkg` です。ファイル名は既存の命名に合わせて `tips-vpkg.md` としています。

---

## 1. 前提条件

事前に次のツールをインストールしておいてください。

| ツール | 用途 |
|---|---|
| Git | vcpkg の取得に使用します |
| Visual Studio 2022 / Build Tools | C++ ライブラリのビルドに使用します |
| CMake | C/C++ プロジェクトのビルド設定に使用します |

Visual Studio を使う場合は、インストーラで次のワークロードを有効にしてください。

- C++ によるデスクトップ開発
- Windows SDK

---

## 2. vcpkg のインストール場所

この手順では、例として次の場所に vcpkg をインストールします。

```powershell
C:\project\vcpkg
```

別の場所にインストールしても構いません。その場合は、以降の `C:\project\vcpkg` を自分の環境に合わせて読み替えてください。

---

## 3. vcpkg を取得する

PowerShell を開き、次のコマンドを実行します。

```powershell
cd C:\project
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg
```

---

## 4. vcpkg を初期化する

次のコマンドで vcpkg を初期化します。

```powershell
.\bootstrap-vcpkg.bat
```

成功すると、`vcpkg.exe` が作成されます。

確認します。

```powershell
.\vcpkg.exe version
```

バージョン情報が表示されれば OK です。

---

## 5. 環境変数を設定する

現在開いている PowerShell だけで使う場合は、次を実行します。

```powershell
$env:VCPKG_ROOT = "C:\project\vcpkg"
$env:Path += ";$env:VCPKG_ROOT"
```

毎回設定したくない場合は、ユーザー環境変数として保存します。

```powershell
setx VCPKG_ROOT "C:\project\vcpkg"
setx PATH "$env:PATH;C:\project\vcpkg"
```

> Note: `setx` で設定した環境変数は、現在開いている PowerShell には反映されません。新しい PowerShell を開き直してください。

---

## 6. GLFW をインストールする

箱庭の MuJoCo viewer などで OpenGL window を使う場合、GLFW が必要になります。

```powershell
cd C:\project\vcpkg
.\vcpkg.exe install glfw3:x64-windows
```

---

## 7. Boost をインストールする

Boost をまとめてインストールする場合は、次を実行します。

```powershell
cd C:\project\vcpkg
.\vcpkg.exe install boost:x64-windows
```

ただし、Boost 全体のインストールは時間がかかることがあります。
必要なコンポーネントが分かっている場合は、個別にインストールする方法もあります。

例:

```powershell
cd C:\project\vcpkg
.\vcpkg.exe install boost-filesystem:x64-windows
.\vcpkg.exe install boost-system:x64-windows
.\vcpkg.exe install boost-program-options:x64-windows
```

箱庭関連のビルド手順で Boost 全体が必要な場合は、まず `boost:x64-windows` を使ってください。

---

## 8. インストール済みパッケージを確認する

次のコマンドで、vcpkg にインストール済みのパッケージを確認できます。

```powershell
cd C:\project\vcpkg
.\vcpkg.exe list
```

`glfw3:x64-windows` や `boost:x64-windows` が表示されれば OK です。

---

## 9. CMake から vcpkg を使う

CMake でビルドするときは、vcpkg の toolchain file を指定します。

```powershell
cmake -B build -S . `
  -DCMAKE_TOOLCHAIN_FILE=C:/project/vcpkg/scripts/buildsystems/vcpkg.cmake
```

`VCPKG_ROOT` を設定している場合は、次のようにも書けます。

```powershell
cmake -B build -S . `
  -DCMAKE_TOOLCHAIN_FILE="$env:VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
```

---

## 10. よくある注意点

### x64-windows を使う

箱庭 Getting Started では、基本的に 64bit Windows を前提にします。
そのため、vcpkg の triplet は `x64-windows` を使います。

```powershell
.\vcpkg.exe install glfw3:x64-windows
.\vcpkg.exe install boost:x64-windows
```

`x86-windows` と混ぜると、Visual Studio や CMake のビルド設定と合わず、リンクエラーになることがあります。

### Visual Studio の C++ 環境が必要

vcpkg は C/C++ ライブラリをビルドするため、Visual Studio 2022 または Build Tools の C++ 環境が必要です。

特に次が入っているか確認してください。

- MSVC C++ compiler
- Windows SDK
- CMake tools for Windows

### PowerShell を開き直す

`setx` で環境変数を設定した後は、新しい PowerShell を開き直してください。
既に開いている PowerShell には反映されません。

---

## 11. 参考情報

- vcpkg official repository: https://github.com/microsoft/vcpkg
- vcpkg documentation: https://learn.microsoft.com/vcpkg/
- vcpkg package: glfw3: https://vcpkg.io/en/package/glfw3.html
