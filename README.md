## Available Languages

- [English](README.md)
- [日本語](README.ja.md)
- [正體中文 (Taiwan)](README.zh-TW.md)
- [简体中文 (China)](README.zh-CN.md)
- [한국어 (Korean)](README.ko.md)
- [Русский (Russian)](README.ru.md)
- [Español (Spanish)](README.es.md)

# gpu-screen-recorder-helper

Start [gpu-screen-recorder](https://git.dec05eba.com/gpu-screen-recorder/about/) easier.

## gpu-screen-recorder-helper

This is a Bash script that wraps the `gpu-screen-recorder` command, providing interactive selection of save directories and filenames, error handling, and multilingual message support.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Localization (Multilingual Support)](#localization-multilingual-support)
- [Notes](#notes)
- [License](#license)

---

## Prerequisites

- Linux environment  
- Bash (`bash >= 4.4`)  
- `gpu-screen-recorder` must be installed (see [here](https://git.dec05eba.com/gpu-screen-recorder/about/)).

---

## Installation

1. Clone the repository or download the script
   ```bash
   git clone https://github.com/bmhh-guy/gpu-screen-recorder-helper.git
   cd gpu-screen-recorder-helper
   ```

2. Grant execution permissions
   ```bash
   chmod +x Record.sh
   ```

3. It is recommended to create a desktop entry.  
   - A desktop entry is included for KDE Plasma + Konsole. It may not work correctly in other desktop environments or terminal emulators.

4. Optionally, add to `$PATH`
   ```bash
   mv YourDesktopEntry /usr/local/bin/rec
   ```

---

## Usage

```bash
# Run the script directly
./Record.sh

# Or use an alias after installation
rec
```

1. **Save Directory**  
   - Default is the XDG standard `VIDEOS` directory.  
   - If not available, falls back to `$HOME/videos`.  
   - Displayed as "Save directory: " at runtime.

2. **Filename Input**  
   - You can input the filename via prompt.  
   - If left blank, a filename like `recording_YYYYMMDD_HHMMSS.mp4` is auto-generated.

3. **Recording Process**
   1. Creates the directory if it does not exist
   2. Checks write permission
   3. Executes `gpu-screen-recorder`
   4. On success, shows a completion message; on failure, prints error output

4. **Stop Recording**  
   - Press Ctrl + Q to end recording. The MP4 file will be saved to the specified directory.

---

## Configuration

You can configure the following options in the "Configuration" section at the top of the script:

```bash
# Example: Change default save directory
default_dir="/mnt/media/screencasts"

# Example: Modify supported languages list
supported_langs=(en ja ru zh ko es)
```

---

## Localization (Multilingual Support)

The script extracts the language code from the `LANG` environment variable and displays messages accordingly.

| Key                     | Example Content                                     |
|------------------------|-----------------------------------------------------|
| `prompt_filename`      | Please enter a filename for output (or leave blank)|
| `default_dir_msg`      | Save directory: ...                                 |
| `command_not_found`    | Command 'gpu-screen-recorder' not found.            |
| `dir_create`           | Directory '%s' does not exist. Creating it.         |
| `dir_no_write`         | No write permission to directory '%s'.              |
| `success`              | Recording complete: %s                              |
| `record_error`         | An error occurred during recording.                |
| `recording_interrupted`| Recording was interrupted.                          |
| `error_line`           | Error at line %s: %s                                |

---

## Notes

- If `gpu-screen-recorder` is not found, the script will exit with an error.  
- If the save directory is not writable, it will error out.  
- Uses strict mode with `set -euo pipefail`, so unexpected errors will stop execution.  
- Auto-generated filenames follow the format `recording_YYYYMMDD_HHMMSS.mp4`.  
- This script is intentionally simple and serves as a template. Please modify it to suit your needs.

---

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

