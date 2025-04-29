## Idiomas disponibles

- [English](README.md)
- [日本語 (Japanese)](README.ja.md)
- [正體中文 (Taiwan)](README.zh-TW.md)
- [简体中文 (China)](README.zh-CN.md)
- [한국어 (Korean)](README.ko.md)
- [Русский (Russian)](README.ru.md)
- [Español (Spanish)](README.es.md)

# gpu-screen-recorder-helper

Ejecute [gpu-screen-recorder](https://git.dec05eba.com/gpu-screen-recorder/about/) fácilmente.

## gpu-screen-recorder-helper

Este es un script en Bash que envuelve el comando `gpu-screen-recorder`, proporcionando selección interactiva del directorio y nombre del archivo de salida, manejo de errores y soporte multilingüe.

---

## Tabla de contenido

- [Requisitos](#requisitos)
- [Instalación](#instalación)
- [Uso](#uso)
- [Configuración](#configuración)
- [Localización (soporte multilingüe)](#localización-soporte-multilingüe)
- [Notas](#notas)
- [Licencia](#licencia)

---

## Requisitos

- Sistema operativo Linux
- Bash (`bash >= 4.4`)
- Comando `gpu-screen-recorder` instalado (ver [aquí](https://git.dec05eba.com/gpu-screen-recorder/about/))

---

## Instalación

1. Clona el repositorio o descarga el script

   ```bash
   git clone https://github.com/bmhh-guy/gpu-screen-recorder-helper.git
   cd gpu-screen-recorder-helper
   ```

2. Da permisos de ejecución

   ```bash
   chmod +x Record.sh
   ```

3. Se recomienda crear una entrada de escritorio.

   - Este repositorio incluye una entrada para KDE Plasma + Konsole. Puede que no funcione correctamente en otros entornos de escritorio o emuladores de terminal.

4. Añade al `$PATH` si es necesario

   ```bash
   mv YourDesktopEntry /usr/local/bin/rec
   ```

---

## Uso

```bash
# Ejecutar el script directamente
./Record.sh

# O bien, tras instalarlo mediante alias
rec
```

1. **Directorio de salida**

   - Por defecto usa el directorio estándar `VIDEOS` según XDG.
   - Si no está disponible, usa `$HOME/videos`.
   - Se muestra como "Directorio de salida:" al ejecutar.

2. **Nombre del archivo**

   - Puedes introducir el nombre manualmente cuando se te solicite.
   - Si se deja vacío, se genera automáticamente como `recording_YYYYMMDD_HHMMSS.mp4`.

3. **Proceso de grabación**

   1. Crea el directorio si no existe
   2. Verifica permisos de escritura
   3. Ejecuta `gpu-screen-recorder`
   4. Muestra mensaje de éxito o error

4. **Finalizar grabación**

   - Presiona Ctrl + Q para detener la grabación. El archivo MP4 se guardará en el directorio especificado.

---

## Configuración

Puedes modificar lo siguiente al inicio del script:

```bash
# Ejemplo para cambiar el directorio predeterminado
default_dir="/mnt/media/screencasts"

# Ejemplo para cambiar los idiomas soportados
supported_langs=(en ja ru zh ko es)
```

---

## Localización (soporte multilingüe)

El script extrae el código de idioma desde la variable de entorno `LANG` y muestra mensajes en el idioma correspondiente.

| Clave                   | Ejemplo de mensaje                                         |
|------------------------|------------------------------------------------------------|
| `prompt_filename`      | Por favor, introduce el nombre del archivo de salida (...) |
| `default_dir_msg`      | Directorio de salida: ...                                  |
| `command_not_found`    | El comando 'gpu-screen-recorder' no fue encontrado.        |
| `dir_create`           | El directorio '%s' no existe. Se creará...                |
| `dir_no_write`         | No hay permisos de escritura en el directorio '%s'.        |
| `success`              | Grabación completada: %s                                  |
| `record_error`         | Ocurrió un error durante la grabación.                   |
| `recording_interrupted`| La grabación fue interrumpida.                            |
| `error_line`           | Error en la línea %s: %s                                   |

---

## Notas

- Si el comando `gpu-screen-recorder` no está presente, el script finalizará con error.
- Si no hay permisos de escritura en el directorio de salida, el script fallará.
- Se usa modo estricto (`set -euo pipefail`), por lo que errores detendrán la ejecución.
- Los nombres de archivo generados siguen el formato `recording_YYYYMMDD_HHMMSS.mp4`.
- Este script es un ejemplo básico. Se recomienda modificarlo según tus necesidades.

---

