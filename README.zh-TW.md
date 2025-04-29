## 可用語言

- [English](README.md)
- [日本語 (Japanese)](README.ja.md)
- [正體中文 (Taiwan)](README.zh-TW.md)
- [简体中文 (China)](README.zh-CN.md)
- [한국어 (Korean)](README.ko.md)
- [Русский (Russian)](README.ru.md)
- [Español (Spanish)](README.es.md)

# gpu-screen-recorder-helper
簡單執行 [gpu-screen-recorder](https://git.dec05eba.com/gpu-screen-recorder/about/)。

## gpu-screen-recorder-helper

這是一個 Bash 腳本，用來包裝 `gpu-screen-recorder` 指令，提供互動式指定儲存資料夾與檔名、錯誤處理、多語系訊息支援等功能。

---

## 目錄

- [先決條件](#先決條件)  
- [安裝](#安裝)  
- [使用方式](#使用方式)  
- [設定](#設定)  
- [本地化（多語系支援）](#本地化多語系支援)  
- [注意事項](#注意事項)  
- [授權條款](#授權條款)  

---

## 先決條件

- Linux 環境  
- Bash（`bash >= 4.4`）  
- 已安裝 `gpu-screen-recorder` 指令（請參閱[此處](https://git.dec05eba.com/gpu-screen-recorder/about/)）。  

---

## 安裝

1. 複製本儲存庫或下載腳本  
   ```bash
   git clone https://github.com/bmhh-guy/gpu-screen-recorder-helper.git
   cd gpu-screen-recorder-helper
   ```

2. 賦予執行權限  
   ```bash
   chmod +x Record.sh
   ```
3. 建議建立桌面捷徑。
   - 本專案附有桌面捷徑，但它是針對 KDE Plasma + Konsole 設計的，其他桌面環境或終端模擬器可能無法正常運作。

4. 如有需要，將其加入 `$PATH`  
   ```bash
   mv YourDesktopEntry /usr/local/bin/rec
   ```

---

## 使用方式

```bash
# 直接執行腳本
./Record.sh

# 或安裝後使用別名
rec
```

1. **儲存資料夾**  
   - 預設使用 XDG 標準的 `VIDEOS` 目錄。  
   - 若無法取得，則使用 `$HOME/videos`。  
   - 執行時會顯示「儲存資料夾: 」

2. **指定檔案名稱**  
   - 可輸入檔名。  
   - 留空則自動產生 `recording_YYYYMMDD_HHMMSS.mp4`。

3. **錄影流程**  
   1. 若指定資料夾不存在，則自動建立  
   2. 檢查寫入權限  
   3. 執行 `gpu-screen-recorder`  
   4. 成功則顯示完成訊息，失敗則輸出錯誤

4. **結束錄影**
   - 按下 Ctrl + Q 結束後，MP4 檔案將儲存在指定資料夾中。

---

## 設定

可於腳本開頭的「設定」區段進行調整。

```bash
# 更改預設儲存資料夾
default_dir="/mnt/media/screencasts"

# 修改支援語言清單
supported_langs=(en ja ru zh ko es)
```

---

## 本地化（多語系支援）

從 `LANG` 環境變數的開頭擷取語言代碼，並顯示對應訊息。

| 鍵值                    | 範例內容                                             |
|-------------------------|------------------------------------------------------|
| `prompt_filename`       | 請輸入輸出檔案名稱（若留空將自動命名）             |
| `default_dir_msg`       | 儲存資料夾: ...                                     |
| `command_not_found`     | 找不到指令 'gpu-screen-recorder'。                  |
| `dir_create`            | 資料夾 '%s' 不存在，將自動建立。                    |
| `dir_no_write`          | 資料夾 '%s' 無寫入權限。                            |
| `success`               | 錄影完成: %s                                        |
| `record_error`          | 錄影過程發生錯誤。                                  |
| `recording_interrupted` | 錄影已中斷。                                        |
| `error_line`            | 錯誤發生於第 %s 行: %s                              |

---

## 注意事項

- 若無 `gpu-screen-recorder` 指令，腳本將立即出錯並結束。  
- 若儲存資料夾無寫入權限，也會錯誤終止。  
- 腳本使用 `set -euo pipefail` 等嚴格模式，可能因未預期錯誤而停止。  
- 自動產生的檔案名稱格式為 `recording_YYYYMMDD_HHMMSS.mp4`。
- 本腳本非常簡單，僅為範例，建議依需求自行修改強化功能。

---

