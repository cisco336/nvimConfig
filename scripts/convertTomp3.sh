#!/bin/bash

SOURCE_DIR="$1"
OUTPUT_DIR="$2"

if [ -z "$SOURCE_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Uso: convertmp3 <fuente> <salida>"
    [[ $_ != $0 ]] && return 1 || exit 1
fi

TARGET_SRC="${SOURCE_DIR%/}"
TARGET_OUT="${OUTPUT_DIR%/}"
mkdir -p "$TARGET_OUT"

echo "--- Iniciando conversión en: $TARGET_SRC ---"

# Activamos nullglob para que si no hay archivos no dé error el bucle
shopt -s nullglob
shopt -s nocaseglob

# Al usar un bucle FOR en lugar de WHILE READ, ffmpeg no puede "robar" caracteres
# porque no hay un flujo de datos (pipe) de entrada.
for FULL_PATH in "$TARGET_SRC"/*.{mp4,mov,avi,mkv}; do

    # Verificar que sea un archivo (por si acaso)
    [ -e "$FULL_PATH" ] || continue

    FILENAME=$(basename "$FULL_PATH")
    FILENAME_NO_EXT="${FILENAME%.*}"
    OUTPUT_FILE="$TARGET_OUT/${FILENAME_NO_EXT}.mp3"

    if [ -f "$OUTPUT_FILE" ]; then
        echo "⏭️  SALTANDO: $FILENAME"
        continue
    fi

    echo ""
    echo "--> Procesando: $FILENAME"

    # Agregamos < /dev/null y -nostdin para seguridad total
    ffmpeg -nostdin -i "$FULL_PATH" -vn -acodec libmp3lame -q:a 2 -loglevel error -y "$OUTPUT_FILE" < /dev/null

    if [ $? -eq 0 ]; then
        echo "✅ ÉXITO"
    else
        echo "❌ ERROR en $FILENAME"
        [ -f "$OUTPUT_FILE" ] && rm "$OUTPUT_FILE"
    fi
done

echo ""
echo "=========================================="
echo "🚀 ¡FINALIZADO!"
echo "=========================================="
