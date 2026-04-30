# 箱庭 (Hakoniwa) — はじめよう

> 箱庭エコシステムへの入口

---

## あなたはこんな悩みを抱えていませんか？

**ROSユーザー・MuJoCoユーザーへ**

- MuJoCoの物理精度は最高だけど、ビジュアライズが弱い
- GazeboはUbuntu前提で重い。セットアップだけで一日終わる
- UnityはライセンスコストがかかりUnrealは重い。Godotを使いたいけどROSとの繋ぎ方がわからない
- ROSのメッセージ型の資産は使いたいけど、ROS環境を毎回構築したくない
- MuJoCoにアクチュエータやLiDAR・IMUのセンサーモデルを自分で実装するのはつらい
- 複数のシミュレータを繋げたとき、時刻がずれて再現性が取れない

**これらは全て、箱庭で解決できます。**

---

## 箱庭とは何か

箱庭は「シミュレータ」ではありません。

**シミュレータを作るためのプラットフォーム**です。

MuJoCo、Godot、Python、C++——それぞれが得意な世界で動きながら、箱庭を介して一つのシミュレーション世界に繋がります。あなたが持っているROS資産（URDF・IDL）をそのまま活かしながら、ROSのインストールは不要です。

```text
あなたのURDF / ROS IDL
        ↓
    箱庭エコシステム
        ↓
MuJoCo（物理）＋ Godot（可視化）＋ Python（制御）
     ↑ 全員が同じ時刻で動いている
```

### 箱庭の時刻同期は数学的に保証されている

ROSのclockには厳密な時刻保証がありません。複数のシミュレータを繋いだとき、時刻のズレは避けられません。

箱庭は違います。どんなアセットのペア(i, j)を選んでも、シミュレーション時刻差は常に最大許容遅延時間 `d_max` 以内であることが数学的に証明されています。

```
|T_i(t) - T_j(t)| ≤ d_max　（任意の時刻 t において）
```

箱庭アセットとして参加するだけで、この保証が自動的についてきます。設定不要です。

→ [時刻同期の数学的証明](https://github.com/hakoniwalab/hakoniwa-design-docs/blob/main/src/math/hakoniwa-time.md)

---

## このチュートリアルで体験できること

このチュートリアルのゴールは、**TurtleBot3をゲームパッドで操作する**です。

```text
ゲームパッド（Python）
      ↓ Twist コマンド（PDU）
  MuJoCo（物理演算 / LiDAR）
      ↓
  Godot（3D可視化）
      ↑ 全て箱庭時刻で同期
```

このたった一つの体験の中に、箱庭の真骨頂が全て詰まっています。

**ここで学べること：**

1. ROS資産（URDF・IDL）を、ROSなしで使う方法
2. MuJoCoとGodotを設定ファイルだけで繋ぐ方法
3. 時刻同期が「勝手についてくる」体験
4. センサーモデル（LiDAR）がすでに用意されている安心感
5. 「つなげることが、意外に簡単だ」という気づき

---

## 対応プラットフォーム

| OS | 対応状況 |
|---|---|
| macOS (arm64) | ✅ |
| Linux (x86_64) | ✅ |
| Windows (x86_64 native) | ✅ |
| Windows (WSL2) | ✅ |

**必要なもの：PythonとC++バイナリのみ。ROSのインストール不要。**

---

## 箱庭エコシステムの全体像

```text
┌──────────────────────────────────────────────┐
│           Registry（アセット鋳造）             │
│  xacro/URDF → URDF / MJCF / GLB / Godotプロファイル  │
│           hakoniwa-mbody-registry             │
└─────────────────┬────────────────────────────┘
                  │
     ┌────────────▼────────────┐
     │     Core & PDU          │
     │  共有メモリ（時刻／PDU）  │
     │   hakoniwa-core-pro     │
     └──────┬──────────┬───────┘
            │          │
   ┌─────────▼──┐  ┌───▼────────────────┐
   │ 可視化      │  │ 物理               │
   │ hakoniwa-  │  │ hakoniwa-          │
   │ godot      │  │ mujoco-robots      │
   │ Godotで    │  │ アクチュエータ・     │
   │ 3D描画     │  │ センサーモデル付き   │
   └────────────┘  └────────────────────┘
```

| レイヤー | リポジトリ | 役割 |
|---|---|---|
| Registry | [hakoniwa-mbody-registry](https://github.com/hakoniwalab/hakoniwa-mbody-registry) | URDF→MJCF/GLB変換、Godotプロファイル生成 |
| Core & PDU | [hakoniwa-core-pro](https://github.com/hakoniwalab/hakoniwa-core-pro) | 時刻同期エンジン |
| PDU定義 | [hakoniwa-pdu-registry](https://github.com/hakoniwalab/hakoniwa-pdu-registry) | ROS IDLベースのデータ型定義 |
| PDU通信 | [hakoniwa-pdu-endpoint](https://github.com/hakoniwalab/hakoniwa-pdu-endpoint) | SHM / Zenoh / MQTT / Storage |
| 可視化 | [hakoniwa-godot](https://github.com/hakoniwalab/hakoniwa-godot) | GodotをPDUノードとして動かすaddon |
| 物理 | [hakoniwa-mujoco-robots](https://github.com/hakoniwalab/hakoniwa-mujoco-robots) | MuJoCo + アクチュエータ・センサーモデル |

---

## チュートリアルを始める

この Getting Started では、まず `hakoniwa-mujoco-robots` と `hakoniwa-godot` を使い、TurtleBot3 を動かすところから始めます。各リポジトリの詳細は、動かした後で理解すれば十分です。

*(準備中 — 近日公開)*

---

## もっと深く知りたい方へ

| 知りたいこと | リンク |
|---|---|
| 箱庭の時刻同期の仕組み | [hakoniwa-core-pro](https://github.com/hakoniwalab/hakoniwa-core-pro) |
| PDUシステムを理解したい | [hakoniwa-pdu-registry](https://github.com/hakoniwalab/hakoniwa-pdu-registry) |
| ロボットモデルを追加したい | [hakoniwa-mbody-registry](https://github.com/hakoniwalab/hakoniwa-mbody-registry) |
| GodotとROSを繋げたい | [hakoniwa-godot](https://github.com/hakoniwalab/hakoniwa-godot) |
| ドローンシミュレーションをやりたい | [箱庭ドローン](https://github.com/toppers/hakoniwa-drone-core) |

---

## 開発・提供元

[合同会社 箱庭ラボ](https://hakoniwa-lab.net/)

箱庭はオープンソースで開発されています。ビジネス利用・導入相談はお気軽にご連絡ください。