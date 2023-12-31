#!/bin/bash
source link_valido.sh

# Comprueba que el link pasado por argumento funcione correctamente. Si el link
# no funciona, vuelve a pedirlo hasta que el link ingresado funcione
# correctamente o hasta que se ingrese '0' para volver al menú.
comprobar_link() {
    LINK=$1
    while ! link_valido $LINK && [[ $LINK != 0 ]]; do
        clear
        read -p "El link ingresado no es válido o no funciona. Intente nuevamente o ingrese '0' para volver al menú: " LINK
    done
    
    if [[ $LINK == 0 ]]; then
        main
    fi
}

# Imprime el menú.
imprimir_menu() {
    clear
    echo "| = = = = = | Procesador de imágenes | = = = = = |

1) Generar imágenes
2) Descargar imágenes
3) Descomprimir, procesar y comprimir las imágenes
0) Salir
"
}

# Función principal.
main() {
    imprimir_menu

    read -p "Ingrese una opción: " OPCION
    while ! [[ $OPCION =~ ^[0-3]$ ]]; do
        imprimir_menu
        read -p "Opción incorrecta. Intente nuevamente: " OPCION
    done

    case $OPCION in
    1)
        clear

        read -p "Ingrese la cantidad de imágenes a generar. Ingrese '0' para volver al menú: " CANT
        while ! [[ $CANT =~ ^[0-9]+$ ]]; do
            clear
            read -p "Cantidad incorrecta, intente nuevamente. Ingrese '0' para volver al menú: " CANT
        done

        ./generar.sh $CANT
        main
    ;;
    2)
        clear
        read -p "Ingrese el link del archivo comprimido a descargar. Ingrese '0' para volver al menú: " LINK_IMAGENES
        comprobar_link $LINK_IMAGENES

        clear
        read -p "Ingrese el link de la suma de verificación. Ingrese '0' para volver al menú: " LINK_SUMA
        comprobar_link $LINK_SUMA

        ./descargar.sh $LINK_IMAGENES $LINK_SUMA
        main
    ;;
    3)
        ./descomprimir.sh || main
        ./procesar.sh || main
        ./comprimir.sh
        main
    ;;
    0)
        exit 0
    ;;
    esac
}

main
