#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit
IFS=$'\n\t'

# ===== 設定 =====
# XDGユーザー環境標準からビデオフォルダを取得し、取得できなければホームの videos
default_dir="$(xdg-user-dir VIDEOS 2>/dev/null || echo "$HOME/videos")"
supported_langs=(en ja ru zh ko es)

# ===== ロケール取得 =====
get_locale() {
    local lang_code="${LANG%%.*}"  # ja_JP.UTF-8 -> ja_JP
    lang_code="${lang_code%%_*}"  # ja_JP -> ja
    for l in "${supported_langs[@]}"; do
        if [[ "$lang_code" == "$l" ]]; then
            echo "$lang_code"
            return
        fi
    done
    echo "en"
}

# ===== メッセージ辞書 =====
declare -A MESSAGES
# 英語
MESSAGES[prompt_filename,en]="Enter output filename (leave empty to auto-name with timestamp in ${default_dir}): "
MESSAGES[default_dir_msg,en]="Save directory: ${default_dir}"
MESSAGES[recording_interrupted,en]="Recording interrupted."
MESSAGES[error_line,en]="Error occurred at line %s: %s"
MESSAGES[command_not_found,en]="Command 'gpu-screen-recorder' not found. Please install it."
MESSAGES[dir_create,en]="Directory '%s' does not exist. Creating."
MESSAGES[dir_no_write,en]="No write permission for directory '%s'."
MESSAGES[success,en]="Recording completed successfully: %s"
MESSAGES[record_error,en]="An error occurred during recording."
# 日本語
MESSAGES[prompt_filename,ja]="出力ファイル名を入力してください（省略すると ${default_dir} に日時付きで保存されます）: "
MESSAGES[default_dir_msg,ja]="保存先ディレクトリ: ${default_dir}"
MESSAGES[recording_interrupted,ja]="録画が中断されました。"
MESSAGES[error_line,ja]="エラー発生 行 %s: %s"
MESSAGES[command_not_found,ja]="コマンド 'gpu-screen-recorder' が見つかりません。インストールしてください。"
MESSAGES[dir_create,ja]="ディレクトリ '%s' が存在しないため作成します。"
MESSAGES[dir_no_write,ja]="ディレクトリ '%s' に書き込み権限がありません。"
MESSAGES[success,ja]="録画が完了しました: %s"
MESSAGES[record_error,ja]="録画中にエラーが発生しました。"
# ロシア語
MESSAGES[prompt_filename,ru]="Введите имя файла (пусто для метки времени в ${default_dir}): "
MESSAGES[default_dir_msg,ru]="Каталог сохранения: ${default_dir}"
MESSAGES[recording_interrupted,ru]="Запись прервана."
MESSAGES[error_line,ru]="Ошибка в строке %s: %s"
MESSAGES[command_not_found,ru]="Команда 'gpu-screen-recorder' не найдена. Установите её."
MESSAGES[dir_create,ru]="Каталог '%s' не существует. Создаю."
MESSAGES[dir_no_write,ru]="Нет прав записи в каталог '%s'."
MESSAGES[success,ru]="Запись завершена: %s"
MESSAGES[record_error,ru]="Ошибка во время записи."
# 中国語
MESSAGES[prompt_filename,zh]="请输入输出文件名（留空则使用时间戳并保存至 ${default_dir}）: "
MESSAGES[default_dir_msg,zh]="保存目录: ${default_dir}"
MESSAGES[recording_interrupted,zh]="录制已中断。"
MESSAGES[error_line,zh]="第 %s 行发生错误: %s"
MESSAGES[command_not_found,zh]="未找到 'gpu-screen-recorder' 命令。请安装。"
MESSAGES[dir_create,zh]="目录 '%s' 不存在，正在创建。"
MESSAGES[dir_no_write,zh]="无 '%s' 目录写入权限。"
MESSAGES[success,zh]="录制完成: %s"
MESSAGES[record_error,zh]="录制时出错。"
# 韓国語
MESSAGES[prompt_filename,ko]="출력 파일 이름을 입력하세요 (비워두면 ${default_dir}에 타임스탬프): "
MESSAGES[default_dir_msg,ko]="저장 디렉토리: ${default_dir}"
MESSAGES[recording_interrupted,ko]="녹화가 중단되었습니다."
MESSAGES[error_line,ko]="라인 %s 오류: %s"
MESSAGES[command_not_found,ko]="'gpu-screen-recorder' 명령을 찾을 수 없습니다. 설치하세요."
MESSAGES[dir_create,ko]="디렉토리 '%s'가 없어 생성합니다."
MESSAGES[dir_no_write,ko]="'%s' 디렉토리에 쓰기 권한이 없습니다."
MESSAGES[success,ko]="녹화 완료: %s"
MESSAGES[record_error,ko]="녹화 중 오류 발생."
# スペイン語
MESSAGES[prompt_filename,es]="Ingrese nombre de archivo (vacío para usar fecha en ${default_dir}): "
MESSAGES[default_dir_msg,es]="Directorio de guardado: ${default_dir}"
MESSAGES[recording_interrupted,es]="Grabación interrumpida."
MESSAGES[error_line,es]="Error en línea %s: %s"
MESSAGES[command_not_found,es]="No se encontró 'gpu-screen-recorder'. Instálelo."
MESSAGES[dir_create,es]="Directorio '%s' no existe. Creando."
MESSAGES[dir_no_write,es]="Sin permisos de escritura en '%s'."
MESSAGES[success,es]="Grabación completada: %s"
MESSAGES[record_error,es]="Error durante la grabación."

# メッセージ取得関数
msg() {
    local key="$1" fmt index
    local lang=$(get_locale)
    index="$key,$lang"
    fmt=${MESSAGES[$index]:-${MESSAGES[$key,en]}}
    printf "$fmt" "${2:-}" "${3:-}"
}

# エラーハンドラ
error_handler() {
    echo "$(msg error_line "$1" "$2")" >&2
}
trap 'error_handler ${LINENO} "$BASH_COMMAND"' ERR

# SIGINT ハンドラ
trap 'echo "$(msg recording_interrupted)"; exit 0' SIGINT

# コマンドチェック
if ! command -v gpu-screen-recorder &>/dev/null; then
    echo "$(msg command_not_found)" >&2
    exit 1
fi

# メイン処理
main() {
    echo "$(msg default_dir_msg)"
    printf "%s" "$(msg prompt_filename)"
    read -r filename

    if [[ -z "$filename" ]]; then
        filename="recording_$(date +%Y%m%d_%H%M%S).mp4"
    fi

    # パス処理
    if [[ "$filename" == /* ]]; then
        output_path="$filename"
    else
        output_path="$default_dir/$filename"
    fi

    dir=$(dirname "$output_path")
    if [[ ! -d "$dir" ]]; then
        printf "%s\n" "$(msg dir_create "$dir")"
        mkdir -p "$dir"
    fi
    if [[ ! -w "$dir" ]]; then
        echo "$(msg dir_no_write "$dir")" >&2
        exit 1
    fi

    if gpu-screen-recorder -w screen -a default_output -q ultra -o "$output_path"; then
        echo "$(msg success "$output_path")"
    else
        echo "$(msg record_error)" >&2
        exit 1
    fi
}

main "$@"
