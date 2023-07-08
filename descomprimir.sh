#!/bin/bash
clear

# Se comprueba que exista el archivo que contiene las imágenes.
if ! [[ -f $ARCHIVO_SALIDA ]]; then
    echo "El archivo '$ARCHIVO_SALIDA' no se encuentra presente. Intente descargarlo o generarlo nuevamente."
    read -p "Presione Enter para continuar..."
    exit 1
fi

# Se borra el directorio temporal en caso de que esté presente.
rm -rf $DIR_TEMPORAL

# Se crea un directorio temporal para guardar las imágenes.
mkdir $DIR_TEMPORAL

# Se descomprimen las imágenes.
tar -xf $ARCHIVO_SALIDA -C $DIR_TEMPORAL

echo "Imágenes descomprimidas."