#!/bin/bash

# Script para procesar videos en un directorio, convirtiéndolos a MP3
# Uso: ./process_video_to_mp3.sh <directorio_fuente> <directorio_salida>

SOURCE_DIR="$1"
OUTPUT_DIR="$2"

if [ -z "$SOURCE_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Uso: $0 <directorio_fuente> <directorio_salida>"
    echo "Ejemplo: $0 ~/openclaw/downloads ~/openclaw/downloads/mp3_output"
    exit 1
fi

echo "--- Iniciando conversión de videos de $SOURCE_DIR a MP3 en $OUTPUT_DIR ---"

mkdir -p "$OUTPUT_DIR"

# Función de verificación y conversión
process_video() {
    local VIDEO_FILE="$1"
    
    # Extraer el nombre base del archivo sin extensión
    FILENAME=$(basename "$VIDEO_FILE")
    FILENAME_NO_EXT="${FILENAME%.*}"
    
    # Crear el nombre del archivo MP3 de salida
    OUTPUT_FILE="$OUTPUT_DIR/${FILENAME_NO_EXT}.mp3"
    
    echo ""
    echo "--> Procesando: $VIDEO_FILE"
    
    # Ejecutar ffmpeg (Se añade -loglevel error para limpiar la salida)
    ffmpeg -i "$VIDEO_FILE" -vn -acodec libmp3lame -loglevel error "$OUTPUT_FILE"
    
    if [ $? -eq 0 ]; then
        echo "✅ ÉXITO: Conversión completa a MP3 en $OUTPUT_FILE"
    else
        echo "❌ ERROR: Falló la conversión de $VIDEO_FILE."
    fi
}

# Buscar todos los archivos de video comunes y procesarlos
find "$SOURCE_DIR" -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.mov" -o -iname "*.avi" \) | while read VIDEO_FILE; do
    process_video "$VIDEO_FILE"
done

echo ""
echo "=========================================="
echo "🚀 ¡SCRIPT DE CONVERSIÓN FINALIZADO! Revisa $OUTPUT_DIR."
echo "=========================================="
