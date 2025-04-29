# gpu-screen-recorder-helper
Start gpu-screen-recorder easier. / 簡単にgpu-screen-recorderを実行する。

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
- `gpu-screen-recorder` コマンドがインストール済みであること（Arch Linuxを利用している場合[AURからインストールできます](https://aur.archlinux.org/packages/gpu-screen-recorder)）。  

---

## インストール

1. リポジトリをクローンまたはスクリプトをダウンロード  
   ```bash
   git clone https://github.com/yourname/gpu-screen-recorder-wrapper.git
   cd gpu-screen-recorder-wrapper
   ```

2. 実行権限を付与  
   ```bash
   chmod +x gpu-screen-recorder-wrapper.sh
   ```

3. 必要に応じて `$PATH` に追加  
   ```bash
   mv gpu-screen-recorder-wrapper.sh /usr/local/bin/gpu-rec
   ```

---

## 使い方

```bash
# スクリプトを直接実行
./gpu-screen-recorder-wrapper.sh

# またはインストール後にエイリアスで
gpu-rec
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

---

## ライセンス

MIT License  

```
Copyright (c) 2025
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
  
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
  
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

