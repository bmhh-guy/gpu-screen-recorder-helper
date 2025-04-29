## 사용 가능한 언어

- [English](README.md)
- [日本語 (Japanese)](README.ja.md)
- [正體中文 (Taiwan)](README.zh-TW.md)
- [简体中文 (China)](README.zh-CN.md)
- [한국어 (Korean)](README.ko.md)
- [Русский (Russian)](README.ru.md)
- [Español (Spanish)](README.es.md)

# gpu-screen-recorder-helper
[gpu-screen-recorder](https://git.dec05eba.com/gpu-screen-recorder/about/)를 간편하게 실행합니다.

## gpu-screen-recorder-helper

`gpu-screen-recorder` 명령어를 래핑한 Bash 스크립트로, 저장 디렉토리 및 파일명 지정, 오류 처리, 다국어 메시지 지원 등의 기능을 제공합니다.

---

## 목차

- [전제 조건](#전제-조건)  
- [설치](#설치)  
- [사용법](#사용법)  
- [설정](#설정)  
- [현지화 (다국어 지원)](#현지화-다국어-지원)  
- [주의 사항](#주의-사항)  
- [라이선스](#라이선스)  

---

## 전제 조건

- Linux 환경  
- Bash (`bash >= 4.4`)  
- `gpu-screen-recorder` 명령어가 설치되어 있어야 합니다 ([링크](https://git.dec05eba.com/gpu-screen-recorder/about/) 참조).  

---

## 설치

1. 저장소를 클론하거나 스크립트 다운로드  
   ```bash
   git clone https://github.com/bmhh-guy/gpu-screen-recorder-helper.git
   cd gpu-screen-recorder-helper
   ```

2. 실행 권한 부여  
   ```bash
   chmod +x Record.sh
   ```
3. 바탕화면 실행 파일 생성 권장.
   - 이 프로젝트에는 KDE Plasma + Konsole 전용으로 제작된 실행 파일이 포함되어 있으며, 다른 데스크탑 환경이나 터미널에서는 제대로 작동하지 않을 수 있습니다.

4. 필요에 따라 `$PATH`에 추가  
   ```bash
   mv YourDesktopEntry /usr/local/bin/rec
   ```

---

## 사용법

```bash
# 스크립트 직접 실행
./Record.sh

# 또는 설치 후 별칭으로 실행
rec
```

1. **저장 디렉토리**  
   - 기본값은 XDG 표준의 `VIDEOS` 디렉토리입니다.  
   - 값을 가져올 수 없을 경우 `$HOME/videos`로 대체됩니다.  
   - 실행 시 "저장 디렉토리:"로 출력됩니다.

2. **파일명 지정**  
   - 프롬프트에서 파일명을 입력할 수 있습니다.  
   - 입력하지 않으면 `recording_YYYYMMDD_HHMMSS.mp4` 형식으로 자동 생성됩니다.

3. **녹화 흐름**  
   1. 지정된 디렉토리가 없으면 자동 생성  
   2. 쓰기 권한 확인  
   3. `gpu-screen-recorder` 실행  
   4. 성공 시 완료 메시지 출력, 실패 시 오류 메시지 출력

4. **녹화 종료**
   - Ctrl + Q 를 누르면 녹화가 종료되고 MP4 파일이 지정된 디렉토리에 저장됩니다.

---

## 설정

스크립트 시작 부분의 "설정" 섹션에서 다음 항목들을 조정할 수 있습니다:

```bash
# 기본 저장 디렉토리 변경 예시
default_dir="/mnt/media/screencasts"

# 지원 언어 목록 변경 예시
supported_langs=(en ja ru zh ko es)
```

---

## 현지화 (다국어 지원)

`LANG` 환경 변수에서 언어 코드를 추출하여 해당 언어로 메시지를 표시합니다.

| 키                      | 메시지 예시                                               |
|-------------------------|------------------------------------------------------------|
| `prompt_filename`       | 출력 파일 이름을 입력해 주세요 (비워두면 자동 생성됩니다) |
| `default_dir_msg`       | 저장 디렉토리: ...                                         |
| `command_not_found`     | 'gpu-screen-recorder' 명령어를 찾을 수 없습니다.           |
| `dir_create`            | 디렉토리 '%s' 가 존재하지 않아 새로 생성합니다.           |
| `dir_no_write`          | 디렉토리 '%s' 에 쓰기 권한이 없습니다.                    |
| `success`               | 녹화 완료: %s                                              |
| `record_error`          | 녹화 중 오류가 발생했습니다.                              |
| `recording_interrupted` | 녹화가 중단되었습니다.                                    |
| `error_line`            | %s 번째 줄에서 오류 발생: %s                               |

---

## 주의 사항

- `gpu-screen-recorder` 명령어가 없으면 스크립트는 오류와 함께 종료됩니다.  
- 저장 디렉토리에 쓰기 권한이 없으면 오류가 발생합니다.  
- `set -euo pipefail` 등 엄격한 모드를 사용하므로, 예기치 않은 오류 발생 시 실행이 중단됩니다.  
- 자동 생성되는 파일명은 `recording_YYYYMMDD_HHMMSS.mp4` 형식입니다.
- 이 스크립트는 매우 단순한 템플릿이며, 필요에 따라 자유롭게 수정하여 사용하시기 바랍니다.

---

