#!/bin/bash

# Uso: convertmp [extensión_salida] [directorio_salida]
# Ejemplo: convertmp mp3 ./musica

convertmp() {
    # 1. Configuración de parámetros
    local EXT_OUT="${1:-mp3}"        # Si no das extensión, usa mp3
    local TARGET_DIR="${2:-$(pwd)}" # Si no das carpeta, usa la actual

    # 2. Verificaciones iniciales
    if ! command -v ffmpeg &> /dev/null; then
        echo "Error: ffmpeg no está instalado."
        return 1
    fi

    mkdir -p "$TARGET_OUT"
    local INPUT_DIR="$(pwd)"

    echo "--- Convirtiendo videos a $EXT_OUT en $TARGET_DIR ---"

    # 3. Bucle robusto
    for file in "$INPUT_DIR"/*; do
      [ -f "$file" ] || continue

      # Verificar si es un video por MIME type
      mimetype=$(file --mime-type -b "$file")
      if [[ "$mimetype" == video/* ]]; then
        filename=$(basename "$file")
        name="${filename%.*}"
        output_file="$TARGET_DIR/$name.$EXT_OUT"

        # Saltamos si ya existe el archivo de salida
        if [ -f "$output_file" ]; then
            echo "⏭️  Saltando: $name (Ya existe)"
            continue
        fi

        echo "--> Procesando: $filename"

        # Ejecución segura de ffmpeg
        ffmpeg -nostdin -i "$file" -vn -acodec libmp3lame -q:a 2 -loglevel error -y "$output_file" < /dev/null

        if [ $? -eq 0 ]; then
            echo "✅ ÉXITO"
        else
            echo "❌ ERROR en $filename"
        fi
      fi
    done
}

# Llamar a la función con los argumentos pasados al script
convertmp "$@"
