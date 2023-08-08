#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main() {
    // Obtener el valor de la variable HOME
    const char *home = getenv("HOME");

    if (home != NULL) {
        // Construir la ruta completa del archivo que deseas incluir
        char path[256]; // Ajusta el tamaño según tus necesidades
        snprintf(path, sizeof(path), "%s/.cache/wall/colors-wal-dwm.h", home);

        // Incluir el archivo utilizando la ruta completa
        // #include path
    } else {
        // La variable HOME no está definida o no se pudo obtener
        printf("Error: No se puede obtener la variable HOME.\n");
    }

    return 0;
}
