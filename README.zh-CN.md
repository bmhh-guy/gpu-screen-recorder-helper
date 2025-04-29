## 可用语言

- [English](README.md)
- [日本語 (Japanese)](README.ja.md)
- [正體中文 (Taiwan)](README.zh-TW.md)
- [简体中文 (China)](README.zh-CN.md)
- [한국어 (Korean)](README.ko.md)
- [Русский (Russian)](README.ru.md)
- [Español (Spanish)](README.es.md)

# gpu-screen-recorder-helper
简单地执行 [gpu-screen-recorder](https://git.dec05eba.com/gpu-screen-recorder/about/)。

## gpu-screen-recorder-helper

这是一个 Bash 脚本，用于封装 `gpu-screen-recorder` 命令，提供交互式设置保存目录与文件名、错误处理和多语言信息支持。

---

## 目录

- [先决条件](#先决条件)  
- [安装](#安装)  
- [使用方法](#使用方法)  
- [设置](#设置)  
- [本地化（多语言支持）](#本地化多语言支持)  
- [注意事项](#注意事项)  
- [许可证](#许可证)  

---

## 先决条件

- Linux 环境  
- Bash（`bash >= 4.4`）  
- 已安装 `gpu-screen-recorder` 命令（请参考[这里](https://git.dec05eba.com/gpu-screen-recorder/about/)）。  

---

## 安装

1. 克隆此仓库或下载脚本  
   ```bash
   git clone https://github.com/bmhh-guy/gpu-screen-recorder-helper.git
   cd gpu-screen-recorder-helper
   ```

2. 添加执行权限  
   ```bash
   chmod +x Record.sh
   ```
3. 推荐创建桌面快捷方式。
   - 本项目附带的桌面快捷方式是为 KDE Plasma + Konsole 设计的，在其他桌面环境或终端模拟器上可能无法正常使用。

4. 如有需要，将其添加到 `$PATH`  
   ```bash
   mv YourDesktopEntry /usr/local/bin/rec
   ```

---

## 使用方法

```bash
# 直接执行脚本
./Record.sh

# 或安装后使用别名
rec
```

1. **保存目录**  
   - 默认使用 XDG 标准的 `VIDEOS` 目录。  
   - 如果无法获取，则使用 `$HOME/videos`。  
   - 执行时会显示“保存目录: ”

2. **指定文件名**  
   - 可在提示时输入文件名。  
   - 如果留空，将自动生成 `recording_YYYYMMDD_HHMMSS.mp4`。

3. **录制流程**  
   1. 若指定目录不存在，则自动创建  
   2. 检查写入权限  
   3. 执行 `gpu-screen-recorder`  
   4. 成功则显示完成消息，失败则输出错误

4. **结束录制**
   - 按 Ctrl + Q 结束录制，MP4 文件将保存在指定目录中。

---

## 设置

可以在脚本开头的“设置”部分调整以下内容：

```bash
# 更改默认保存目录
default_dir="/mnt/media/screencasts"

# 修改支持语言列表
supported_langs=(en ja ru zh ko es)
```

---

## 本地化（多语言支持）

脚本会从 `LANG` 环境变量前缀中提取语言代码，并显示对应的消息。

| 键名                     | 示例内容                                             |
|--------------------------|------------------------------------------------------|
| `prompt_filename`        | 请输入输出文件名（留空将自动命名）                 |
| `default_dir_msg`        | 保存目录: ...                                       |
| `command_not_found`      | 未找到命令 'gpu-screen-recorder'。                 |
| `dir_create`             | 目录 '%s' 不存在，正在创建。                       |
| `dir_no_write`           | 目录 '%s' 没有写入权限。                           |
| `success`                | 录制完成: %s                                        |
| `record_error`           | 录制过程中发生错误。                               |
| `recording_interrupted`  | 录制已中断。                                       |
| `error_line`             | 第 %s 行发生错误: %s                                |

---

## 注意事项

- 如果未安装 `gpu-screen-recorder` 命令，脚本将直接出错并退出。  
- 如果保存目录没有写入权限，脚本也会出错终止。  
- 脚本使用 `set -euo pipefail` 等严格模式，遇到意外错误将会终止执行。  
- 自动生成的文件名格式为 `recording_YYYYMMDD_HHMMSS.mp4`。
- 本脚本非常简单，仅为模板。请根据需求自行修改以增强功能。

---

