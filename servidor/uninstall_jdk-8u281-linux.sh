#!/bin/bash

# Define variables para versiones y rutas (deben coincidir con el script de instalación)
JDK_VERSION_DIR="jdk1.8.0_281"
INSTALL_DIR="/usr/lib/jvm"
JDK_FULL_PATH="${INSTALL_DIR}/${JDK_VERSION_DIR}"

# Patrones de inicio y fin de comentario que el script de instalación añadió a .bashrc
START_COMMENT="# >>> Configuración para Oracle JDK ${JDK_VERSION_DIR} añadida por script <<<"
END_COMMENT="# <<< Fin Configuración Oracle JDK ${JDK_VERSION_DIR} <<<"


# --- Verificaciones Iniciales ---

# 1. Comprobar si el script se ejecuta como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: Este script debe ejecutarse con privilegios de root. Por favor, use 'sudo bash $(basename "$0")'."
    exit 1
fi

# 2. Comprobar si se ejecutó a través de sudo y obtener el usuario original
# Necesitamos el usuario original para modificar su .bashrc
if [ -z "$SUDO_USER" ]; then
    # Si no se usó sudo, quizás se ejecutó directamente como root.
    # En este caso, no hay un SUDO_USER para modificar su bashrc.
    # Podemos proceder con la desinstalación del sistema (archivos, alternatives)
    # pero notificar que no se modificará .bashrc de usuario.
    echo "Advertencia: No se detectó SUDO_USER. Asumiendo ejecución directa como root."
    echo "Se desinstalarán los archivos del sistema y alternativas, pero no se modificará el .bashrc de ningún usuario."
    ORIGINAL_USER="root" # dummy value, won't be used for bashrc mod
    USER_HOME="/root"    # dummy value
    USER_BASHRC="/root/.bashrc" # dummy value, but will be checked below
else
    ORIGINAL_USER="$SUDO_USER"
    # Obtener el directorio home del usuario original
    USER_HOME=$(getent passwd "$ORIGINAL_USER" | cut -d: -f6)

    if [ -z "$USER_HOME" ]; then
        echo "Error: No se pudo determinar el directorio home para el usuario '$ORIGINAL_USER'."
        echo "Por favor, asegúrese de que el usuario '$ORIGINAL_USER' existe y tiene un directorio home configurado."
        echo "La desinstalación de los archivos del sistema y alternativas continuará, pero no se modificará el .bashrc."
        # Proceder pero sin modificar bashrc
        ORIGINAL_USER="root" # Set dummy values to skip bashrc modification section
        USER_HOME="/root"
        USER_BASHRC="/root/.bashrc"
    else
        USER_BASHRC="${USER_HOME}/.bashrc"
        echo "Usuario original detectado: $ORIGINAL_USER"
        echo "Directorio home del usuario: $USER_HOME"
        echo "Archivo .bashrc del usuario a modificar: $USER_BASHRC"
    fi
fi

echo "--- Iniciando Proceso de Desinstalación ---"

# 3. Comprobar si el JDK está instalado en la ruta esperada
if [ ! -d "$JDK_FULL_PATH" ]; then
    echo "El JDK $JDK_VERSION_DIR no parece estar instalado en $JDK_FULL_PATH."
    echo "No hay nada que desinstalar en esta ubicación."

    # Si el directorio no existe, ¿estaban las alternativas o las variables de entorno?
    # Podríamos intentar limpiarlas de todos modos, pero para este script,
    # si la carpeta principal no está, asumimos que la instalación principal no está.
    # Sin embargo, limpiemos las alternativas por si acaso quedaron residuos.
    echo "Intentando limpiar entradas obsoletas en update-alternatives..."
    update-alternatives --remove java "${JDK_FULL_PATH}/bin/java" 2>/dev/null
    update-alternatives --remove javac "${JDK_FULL_PATH}/bin/javac" 2>/dev/null
    echo "Limpieza de alternativas completada (si había)."

    # También podemos intentar limpiar el bashrc del usuario original si fue detectado
    if [ "$ORIGINAL_USER" != "root" ] && [ -f "$USER_BASHRC" ]; then
         echo "Intentando limpiar entradas obsoletas en $USER_BASHRC para el usuario $ORIGINAL_USER..."
         # Verificar si el bloque de comentarios existe antes de intentar eliminar
        if grep -q "^${START_COMMENT}" "$USER_BASHRC" 2>/dev/null; then
            # Eliminar el bloque de líneas entre los comentarios
            sed -i "/^${START_COMMENT}/,/^${END_COMMENT}/d" "$USER_BASHRC"
            echo "Entradas de JAVA_HOME eliminadas de $USER_BASHRC."
        else
             echo "Las entradas de JAVA_HOME para este JDK no se encontraron en $USER_BASHRC."
        fi
    fi

    echo "Proceso de desinstalación completado (no se encontraron archivos del JDK)."
    exit 0
fi

# --- Proceso de Desinstalación ---

# 4. Eliminar el directorio de instalación del JDK
echo "Eliminando directorio de instalación: $JDK_FULL_PATH..."
if rm -rf "$JDK_FULL_PATH"; then
    echo "Directorio de instalación eliminado correctamente."
else
    echo "Error: Falló la eliminación del directorio $JDK_FULL_PATH."
    echo "Puede que necesite eliminarlo manualmente."
    # Continuamos intentando limpiar alternativas y bashrc, aunque la eliminación fallara
fi

# 5. Eliminar entradas del JDK en update-alternatives
echo "Eliminando entradas en update-alternatives..."
# update-alternatives --remove no falla si la entrada no existe, solo imprime un mensaje
update-alternatives --remove java "${JDK_FULL_PATH}/bin/java"
update-alternatives --remove javac "${JDK_FULL_PATH}/bin/javac"
echo "Limpieza de update-alternatives completada."

# 6. Eliminar variables de entorno del .bashrc del usuario original
# Solo intentamos modificar el .bashrc si detectamos un usuario SUDO_USER válido
if [ "$ORIGINAL_USER" != "root" ] && [ -f "$USER_BASHRC" ]; then
    echo "Eliminando variables de entorno de JAVA_HOME de $USER_BASHRC para el usuario $ORIGINAL_USER..."

    # Verificar si el bloque de comentarios que delimita las variables existe
    # Usamos 2>/dev/null para suprimir errores si el archivo .bashrc no existe (poco probable para un usuario con home)
    if grep -q "^${START_COMMENT}" "$USER_BASHRC" 2>/dev/null; then
        # Eliminar el bloque de líneas entre los comentarios añadidos por el instalador
        # ^${START_COMMENT} : Busca la línea que empieza exactamente con START_COMMENT
        # /^${END_COMMENT}/ : Busca la línea que empieza exactamente con END_COMMENT
        # d : Indica la acción de eliminar las líneas en el rango especificado
        sed -i "/^${START_COMMENT}/,/^${END_COMMENT}/d" "$USER_BASHRC"
        echo "Variables de entorno eliminadas de $USER_BASHRC."
    else
        echo "Las variables de entorno para este JDK no se encontraron en $USER_BASHRC."
        echo "Puede que necesite eliminarlas manualmente si fueron añadidas de otra forma."
    fi
else
    # Este mensaje se muestra si no se usó sudo o no se pudo determinar el home del usuario original
    echo "No se pudo identificar al usuario que ejecutó sudo o su archivo .bashrc."
    echo "Las variables de entorno (JAVA_HOME, PATH) no se eliminaron automáticamente de ningún .bashrc de usuario."
    echo "Si las configuró manualmente, deberá eliminarlas usted mismo."
fi

# --- Finalización ---

echo "--- Desinstalación del JDK ${JDK_VERSION_DIR} completada ---"
echo "Para que los cambios surtan efecto en la terminal del usuario $ORIGINAL_USER,"
echo "este usuario debe ejecutar:"
echo "source $USER_BASHRC"
echo "o abrir una nueva ventana de terminal."

exit 0