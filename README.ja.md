## 利用可能な言語

- [English](README.md)
- [日本語](README.ja.md)
- [正體中文 (Taiwan)](README.zh-TW.md)
- [简体中文 (China)](README.zh-CN.md)
- [한국어 (Korean)](README.ko.md)
- [Русский (Russian)](README.ru.md)
- [Español (Spanish)](README.es.md)

# gpu-screen-recorder-helper
簡単に[gpu-screen-recorder](https://git.dec05eba.com/gpu-screen-recorder/about/)を実行する。

## gpu-screen-recorder-helper

`gpu-screen-recorder` コマンドをラップし、保存先ディレクトリやファイル名の対話的指定、エラーハンドリング、多言語メッセージ対応を提供する Bash スクリプトです。

---

## 目次

- [前提条件](#前提条件)  
- [インストール](#インストール)  
- [使い方](#使い方)  
- [設定](#設定)  
- [ローカライズ (多言語対応)](#ローカライズ-多言語対応)  
- [注意点](#注意点)  
- [ライセンス](#ライセンス)  

---

## 前提条件

- Linux 環境  
- Bash (`bash >= 4.4`)  
- `gpu-screen-recorder` コマンドがインストール済みであること（[こちら](https://git.dec05eba.com/gpu-screen-recorder/about/)を参照してください）。  

---

## インストール

1. リポジトリをクローンまたはスクリプトをダウンロード  
   ```bash
   git clone https://github.com/bmhh-guy/gpu-screen-recorder-helper.git
   cd gpu-screen-recorder-helper
   ```

2. 実行権限を付与  
   ```bash
   chmod +x Record.sh
   ```
3. デスクトップエントリを作成することをおすすめします。
   - gpu-screen-recorder-helperには私が作成したデスクトップエントリが含まれますが、これはKDE Plasma + Konsole向けに作成されており、他のDEやターミナルエミュレータでは正しく機能しない可能性があります。

5. 必要に応じて `$PATH` に追加  
   ```bash
   mv YourDesktopEntry /usr/local/bin/rec
   ```

---

## 使い方

```bash
# スクリプトを直接実行
./Record.sh

# またはインストール後にエイリアスで
rec
```

1. **保存先ディレクトリ**  
   - デフォルトは XDG 標準の `VIDEOS` ディレクトリ。  
   - 取得できない場合は `$HOME/videos`。  
   - 実行時に「保存先ディレクトリ: 」として表示。

2. **ファイル名指定**  
   - プロンプトでファイル名を入力可能。  
   - 空入力なら `recording_YYYYMMDD_HHMMSS.mp4` を自動生成。

3. **録画処理の流れ**  
   1. 指定ディレクトリが存在しなければ自動作成  
   2. 書き込み権限をチェック  
   3. `gpu-screen-recorder` 実行  
   4. 成功時は完了メッセージ、失敗時はエラー出力

4. **録画の終了**
   - Ctrl + Qで終了すると、指定したディレクトリにMP4ファイルが作成されます。
---

## 設定

スクリプト冒頭の「設定」セクションで以下を調整可能です。

```bash
# デフォルト保存先ディレクトリを変更する例
default_dir="/mnt/media/screencasts"

# 対応言語リストを変更する例
supported_langs=(en ja ru zh ko es)
```

---

## ローカライズ (多言語対応)

`LANG` 環境変数の先頭部分から言語コードを抽出し、以下のメッセージを表示します。

| キー                       | 内容例                                           |
|----------------------------|--------------------------------------------------|
| `prompt_filename`          | 出力ファイル名を入力してください（省略すると…）  |
| `default_dir_msg`          | 保存先ディレクトリ: ...                          |
| `command_not_found`        | コマンド 'gpu-screen-recorder' が見つかりません。|
| `dir_create`               | ディレクトリ '%s' が存在しないため作成します。    |
| `dir_no_write`             | ディレクトリ '%s' に書き込み権限がありません。    |
| `success`                  | 録画が完了しました: %s                            |
| `record_error`             | 録画中にエラーが発生しました。                   |
| `recording_interrupted`    | 録画が中断されました。                           |
| `error_line`               | エラー発生 行 %s: %s                             |

---

## 注意点

- `gpu-screen-recorder` コマンドが存在しない場合、スクリプト実行時にエラーで終了します。  
- 保存先ディレクトリに書き込み権限がない場合はエラーとなります。  
- `set -euo pipefail` など厳格モードを利用しているため、予期しないエラーで停止します。  
- 自動生成されるファイル名は `recording_YYYYMMDD_HHMMSS.mp4` 形式です。
- このスクリプトはシンプルすぎます。このスクリプトはあくまでもひな型です。ご自身でスクリプトを編集して改良してください。

---
