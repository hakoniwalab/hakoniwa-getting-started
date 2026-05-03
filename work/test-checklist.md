# TB3 手順テストチェックリスト

このファイルは、`docs/add-your-robot.md` を TB3 例で順に検証するための作業チェックリストです。

基本方針:

- 作業ディレクトリは `work/` 配下を使う
- 比較対象は `godot/tb3-viewer-template/`
- 不具合修正が必要なら `../hakoniwa-mbody-registry` 側で行う
- 各ステップで、実行結果と気づいた問題をこのファイルか別ログに残す

## 0. 事前準備

- [x] `../hakoniwa-mbody-registry` が存在する
- [x] `docs/add-your-robot.md` の最新版を確認した
- [x] `work/logs/` を作成する
- [x] `work/generated/` を作成する
- [x] `work/godot/` を作成する
- [x] 比較対象として `godot/tb3-viewer-template/` の構成を確認した

確認メモ:

- 参照テンプレート:
  - `godot/tb3-viewer-template/assets/`
  - `godot/tb3-viewer-template/config/`
- テスト成果物の配置先:
  - `work/generated/`
  - `work/godot/`
- 確認済みサブディレクトリ:
  - `godot/tb3-viewer-template/assets/parts/`
  - `godot/tb3-viewer-template/config/comm/`

## 1. 前提条件の確認

- [x] `../hakoniwa-mbody-registry` へ移動できる
- [x] 必要な Python 依存が入っている
- [x] 必要な外部ツールが揃っている
- [x] ここで詰まる場合、手順書に不足前提がないか記録した

確認したいこと:

- `pip install -r requirements.txt` で足りるか
- MuJoCo 変換に追加前提がないか
- GLB 生成に追加前提がないか

記録:

- 実行コマンド: `python3 --version`, `pip3 --version`, `python3 -c 'import xacro,yaml,mujoco,trimesh'`
- 結果: `python3` は 3.12.3、主要 Python モジュール import は成功
- 問題: `pip3` が Python 3.10 系を向いており、`python3` と不一致。手順書の `pip install -r requirements.txt` は `python3 -m pip install -r requirements.txt` に寄せた方が安全

## 2. Step 1: ロボット定義の取得

- [x] `tools/fetch.py sources/tb3.yaml` を実行した
- [x] 取得先が想定どおりに作られた
- [x] `bodies/turtlebot3/source/` に必要ファイルがある
- [x] 取得漏れや upstream 依存の問題がない

期待成果物:

- `bodies/turtlebot3/source/`

記録:

- 実行コマンド: `/Users/tmori/project/oss/hakoniwa-getting-started/work/venv/bin/python tools/fetch.py sources/tb3.yaml`
- 出力先: `../hakoniwa-mbody-registry/bodies/turtlebot3/source/`
- 問題: `work/venv` の Python を使う必要があった。ホストの `python3` に依存を直接入れる手順ではなかった

## 3. Step 2: xacro -> plain URDF

- [x] `tools/xacro2urdf.py` を実行した
- [x] `generated/turtlebot3_burger.urdf` が生成された
- [x] 出力 URDF を開いて内容を確認した
- [x] 手順書の入力例と実ファイル構成にズレがない

期待成果物:

- `bodies/turtlebot3/generated/turtlebot3_burger.urdf`

記録:

- 実行コマンド: `/Users/tmori/project/oss/hakoniwa-getting-started/work/venv/bin/python tools/xacro2urdf.py bodies/turtlebot3/source/turtlebot3_description/urdf/turtlebot3_burger.urdf`
- 出力先: `../hakoniwa-mbody-registry/bodies/turtlebot3/generated/turtlebot3_burger.urdf`
- 問題: xacro 展開は成功したが、mesh の `package://...` 参照は残っている。後続ツール側での解決確認が必要

## 4. Step 3: URDF -> MJCF

- [x] `tools/urdf2mjcf.py` を実行した
- [x] `generated/turtlebot3_burger.xml` が生成された
- [x] 変換エラーがない
- [x] mesh 解決や `package://` 解決に問題がない

期待成果物:

- `bodies/turtlebot3/generated/turtlebot3_burger.xml`

記録:

- 実行コマンド: `/Users/tmori/project/oss/hakoniwa-getting-started/work/venv/bin/python tools/urdf2mjcf.py bodies/turtlebot3/generated/turtlebot3_burger.urdf`
- 出力先: `../hakoniwa-mbody-registry/bodies/turtlebot3/generated/turtlebot3_burger.xml`
- 問題: なし。`package://` mesh は MJCF 側で絶対パスに解決された

## 5. Step 4: actuator 追加

- [x] `tools/mjcf_add_actuators.py` を実行した
- [x] `generated/turtlebot3_burger.actuated.xml` が生成された
- [x] actuator の joint 名が MJCF と一致している
- [x] 生成結果に actuator が追加されている

期待成果物:

- `bodies/turtlebot3/generated/turtlebot3_burger.actuated.xml`

記録:

- 実行コマンド: `/Users/tmori/project/oss/hakoniwa-getting-started/work/venv/bin/python tools/mjcf_add_actuators.py bodies/turtlebot3/generated/turtlebot3_burger.xml bodies/turtlebot3/config/actuators.yaml`
- 出力先: `../hakoniwa-mbody-registry/bodies/turtlebot3/generated/turtlebot3_burger.actuated.xml`
- 問題: なし

## 6. Step 5: GLB パーツ生成

- [x] `tools/urdf2glb.py` を実行した
- [x] `generated/parts/*.glb` が生成された
- [x] 主要パーツのファイル名を確認した
- [x] テンプレートの `assets/parts/*.glb` と対応を確認した

期待成果物:

- `bodies/turtlebot3/generated/parts/base_link.glb`
- `bodies/turtlebot3/generated/parts/base_scan.glb`
- `bodies/turtlebot3/generated/parts/caster_back_link.glb`
- `bodies/turtlebot3/generated/parts/wheel_left_link.glb`
- `bodies/turtlebot3/generated/parts/wheel_right_link.glb`

記録:

- 実行コマンド: `/Users/tmori/project/oss/hakoniwa-getting-started/work/venv/bin/python tools/urdf2glb.py bodies/turtlebot3/generated/turtlebot3_burger.urdf --parts-dir bodies/turtlebot3/generated/parts`
- 出力先: `../hakoniwa-mbody-registry/bodies/turtlebot3/generated/parts/`
- 差分: 生成ファイル名はテンプレートと一致
- 問題: `caster_back_link.glb` は実際には生成されたが、ツール標準出力には表示されなかった。ログメッセージ不整合の可能性あり

## 7. Step 6: PDU 定義生成

- [x] `tools/pdu_manifest2types.py` を実行した
- [x] `tools/pdu_manifest2def.py` を実行した
- [x] `generated/pdutypes.json` が生成された
- [x] `generated/pdu_def.json` が生成された
- [x] テンプレートの `config/comm/` 配下との対応関係を確認した

期待成果物:

- `bodies/turtlebot3/generated/pdutypes.json`
- `bodies/turtlebot3/generated/pdu_def.json`

記録:

- 実行コマンド: `/Users/tmori/project/oss/hakoniwa-getting-started/work/venv/bin/python tools/pdu_manifest2types.py bodies/turtlebot3/config/pdu-manifest.yaml` と `/Users/tmori/project/oss/hakoniwa-getting-started/work/venv/bin/python tools/pdu_manifest2def.py bodies/turtlebot3/config/pdu-manifest.yaml`
- 出力先: `../hakoniwa-mbody-registry/bodies/turtlebot3/generated/pdutypes.json`, `../hakoniwa-mbody-registry/bodies/turtlebot3/generated/pdu_def.json`
- 差分: 内容はテンプレートと実質一致。`pdu_def.json` の `path` は `pdutypes.json`、テンプレートは `tb3-pdutypes.json`
- 問題: 命名と配置時の参照パスに差分あり。スキーマ不一致ではない

## 8. Step 7-1: viewer model JSON 生成

- [x] `tools/hako_viewer_model_gen.py` を実行した
- [x] `bodies/turtlebot3/view/turtlebot3.json` が生成された
- [x] ボディ構造と GLB 参照が妥当か確認した

期待成果物:

- `bodies/turtlebot3/view/turtlebot3.json`

記録:

- 実行コマンド: `/Users/tmori/project/oss/hakoniwa-getting-started/work/venv/bin/python tools/hako_viewer_model_gen.py bodies/turtlebot3/config/viewer.recipe.yaml -o bodies/turtlebot3/view/turtlebot3.json --pretty`
- 出力先: `../hakoniwa-mbody-registry/bodies/turtlebot3/view/turtlebot3.json`
- 問題: なし。`caster_back_link` は viewer model に含まれないが、テンプレートの `TurtleBot3.generated.tscn` も同様に参照していないため、現行仕様と整合

## 9. Step 7-2: robot sync profile 生成

- [x] `tools/godot_sync2profile.py` を実行した
- [x] `generated/godot/robot_sync.profile.json` が生成された
- [x] テンプレートの `config/robot_sync.profile.json` と比較した
- [x] node path と PDU 対応が妥当か確認した

期待成果物:

- `bodies/turtlebot3/generated/godot/robot_sync.profile.json`

記録:

- 実行コマンド: `/Users/tmori/project/oss/hakoniwa-getting-started/work/venv/bin/python tools/godot_sync2profile.py bodies/turtlebot3/config/godot_sync.yaml bodies/turtlebot3/view/turtlebot3.json`
- 出力先: `../hakoniwa-mbody-registry/bodies/turtlebot3/generated/godot/robot_sync.profile.json`
- 差分: なし。テンプレートと一致
- 問題: なし

## 10. Step 7-3: Godot endpoint 設定生成

- [x] `tools/godot_sync2endpoint.py` を実行した
- [x] endpoint 設定 JSON が生成された
- [x] ファイル名が手順書とテンプレート実体で一致するか確認した
- [x] テンプレートの `config/endpoint_shm_poll_with_pdu.json` と比較した

期待成果物:

- `bodies/turtlebot3/generated/endpoint_shm_with_pdu.json` または相当ファイル

記録:

- 実行コマンド: `/Users/tmori/project/oss/hakoniwa-getting-started/work/venv/bin/python tools/godot_sync2endpoint.py bodies/turtlebot3/config/godot_sync.yaml`
- 出力先: `../hakoniwa-mbody-registry/bodies/turtlebot3/generated/endpoint_shm_with_pdu.json`
- 差分: デフォルト出力は `pdu_def_path: pdu_def.json` とファイル名 `endpoint_shm_with_pdu.json` を使う。テンプレート再現時は `-o .../endpoint_shm_poll_with_pdu.json --pdu-def-path comm/tb3-pdudef-compact.json` が必要
- 問題: 不具合あり。`../hakoniwa-mbody-registry` 側で修正済み。修正内容は `tools/godot_sync2endpoint.py` の relative path 処理と `bodies/turtlebot3/config/godot_sync.yaml` の `comm_path`

## 11. Step 7-4: Godot scene 生成

- [x] `tools/hako_godot_scene_gen.py` を実行した
- [x] `.tscn` が生成された
- [x] 同期スクリプト参照が妥当か確認した
- [x] テンプレートの `assets/TurtleBot3.generated.tscn` と比較した

期待成果物:

- `bodies/turtlebot3/godot_tb3_reference/TurtleBot3.generated.tscn`

記録:

- 実行コマンド: `work/venv/bin/python ../hakoniwa-mbody-registry/tools/hako_godot_scene_gen.py ../hakoniwa-mbody-registry/bodies/turtlebot3/view/turtlebot3.json -o ../hakoniwa-mbody-registry/bodies/turtlebot3/godot_tb3_reference/TurtleBot3.generated.tscn`
- 出力先: `../hakoniwa-mbody-registry/bodies/turtlebot3/godot_tb3_reference/TurtleBot3.generated.tscn`
- 差分: major runtime structure mismatch was fixed by introducing `godot_scene.yaml` support, `HakoSync` wrapper generation, `HakoniwaSimNode` / `HakoniwaCodecNode`, template-compatible path layout, and default materials
- 問題: 残差あり。`CameraRig` は仕様どおり generator 対象外、uid/unique_id/editor 固有値は未再現、Transform3D の表現差や metadata の uid 文字列差は残る

## 12. Step 8: `work/` 配下へ配置

- [x] `work/godot/tb3-viewer-template/` を検証用配置先として作成した
- [x] 生成した `.glb` を `work/godot/tb3-viewer-template/assets/parts/` に配置した
- [x] 生成した `.tscn` を `work/godot/tb3-viewer-template/assets/` に配置した
- [x] 同期スクリプトを `work/godot/tb3-viewer-template/assets/` に配置した
- [x] `robot_sync.profile.json` を `work/godot/tb3-viewer-template/config/` に配置した
- [x] endpoint 設定を `work/godot/tb3-viewer-template/config/` に配置した
- [x] PDU 定義を `work/godot/tb3-viewer-template/config/comm/` に配置した

確認したいこと:

- 手順書のコピー先指定と実テンプレート構成のズレ
- `assets/` 配下に置くべきか、プロジェクト直下に置くべきか

記録:

- 配置先: `work/godot/tb3-viewer-template/`
- 差分: `comm/shm_poll_comm.json` と `cache/buffer.json` は template から静的コピーした
- 問題: なし。endpoint file は earlier validation step で先行生成済みだったため、同一ファイルコピーで一度停止したが、最終配置は完了

## 13. 比較チェック

- [x] `work/godot/tb3-viewer-template/assets/TurtleBot3.generated.tscn` を比較した
- [x] `work/godot/tb3-viewer-template/assets/parts/*.glb` を比較した
- [x] `work/godot/tb3-viewer-template/config/robot_sync.profile.json` を比較した
- [x] `work/godot/tb3-viewer-template/config/endpoint_shm_poll_with_pdu.json` 相当を比較した
- [x] `work/godot/tb3-viewer-template/config/comm/tb3-pdutypes.json` 相当を比較した
- [x] `work/godot/tb3-viewer-template/config/comm/tb3-pdudef-compact.json` 相当を比較した

記録:

- 一致したもの: `assets/parts/*.glb` はバイナリ一致。`config/robot_sync.profile.json` と `config/endpoint_shm_poll_with_pdu.json` は一致
- 差分があるもの: `assets/TurtleBot3.generated.tscn`, `assets/tb3_reference_sync.gd`, `config/comm/tb3-pdutypes.json`, `config/comm/tb3-pdudef-compact.json`
- 差分理由: scene は `CameraRig` 非生成、uid/unique_id/editor 固有値未再現、Transform3D 表現差、metadata uid 文字列差。sync script は null guard 追加による軽微差。`tb3-pdutypes.json` は整形差のみ。`tb3-pdudef-compact.json` は `path: pdutypes.json` と `path: tb3-pdutypes.json` の命名差が残る

## 14. 不具合対応

- [x] 問題が手順書の不備か、ツール不具合か、テンプレート差分かを分類した
- [x] ツール不具合なら `../hakoniwa-mbody-registry` 側で修正した
- [x] 修正後に該当ステップを再実行した
- [x] 再実行結果を `work/` 配下に保存した

記録:

- 問題分類: endpoint path handling はツール不具合、scene/runtime 構造差は generator 仕様不足、caster unused は仕様差、pdu_def compact name は staging 規約差、camera rig 欠如は仕様どおり
- 修正箇所: `../hakoniwa-mbody-registry/tools/godot_sync2endpoint.py`, `../hakoniwa-mbody-registry/bodies/turtlebot3/config/godot_sync.yaml`, `../hakoniwa-mbody-registry/tools/hako_godot_scene_gen.py`, `../hakoniwa-mbody-registry/docs/spec/godot-scene-spec.md`, `../hakoniwa-mbody-registry/bodies/turtlebot3/config/godot_scene.yaml`
- 再実行結果: `endpoint_shm_poll_with_pdu.json` は一致、`robot_sync.profile.json` は一致、GLB はバイナリ一致。残差は `.tscn` の editor/serialization 差、`tb3_reference_sync.gd` の null guard 差、PDU JSON の整形差

## 15. 最終判定

- [x] TB3 手順テストを最後まで通した
- [x] 手順書だけで再現可能と言える状態か判定した
- [x] `issue.md` に沿った完了条件を満たしているか確認した
- [x] 残課題を列挙した

最終メモ:

- 成功した点: GLB は 5 ファイルともバイナリ一致。`robot_sync.profile.json` と `endpoint_shm_poll_with_pdu.json` は一致。PDU JSON は内容一致。generator / endpoint 周りの実不具合は `../hakoniwa-mbody-registry` 側で修正できた
- 失敗した点: `TurtleBot3.generated.tscn` はまだテキスト完全一致ではない。`tb3_reference_sync.gd` も null guard 追加差分が残る
- 手順書の修正が必要な点: canonical 生成物名と template 側 staging 名の違い、`assets/` / `config/comm/` への配置、camera rig を手で追加する手順、`python3 -m pip` を使う方が安全な点
- `../hakoniwa-mbody-registry` 側の修正が必要な点: 追加の必須修正は今回対応済み。今後の改善候補は `.tscn` の text reproduction をどこまで追うか、JSON formatting を template に合わせるかの判断
