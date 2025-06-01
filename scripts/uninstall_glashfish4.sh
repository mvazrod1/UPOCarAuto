#!/bin/bash

# Este script debe ejecutarse con privilegios de root
# Script para desinstalar GlassFish 4.1.1 instalado con el script complementario.
# Elimina el directorio de instalacion, el servicio systemd, las variables de entorno del usuario
# y los archivos de configuracion SSL creados en /etc.
# Uso: Ejecutar este script con sudo. Se recomienda desde la cuenta del usuario que instalo GlassFish.
# Ejemplo: sudo bash ./uninstall_grashfish4.sh

# Definir variables (deben coincidir con el script de instalacion)
GLASSFISH_VERSION="4.1.1" # Se mantiene aunque no se use directamente en la desinstalacion
INSTALL_DIR="/opt"      # Se mantiene aunque no se use directamente
GLASSFISH_HOME="${INSTALL_DIR}/glassfish4" # Directorio principal de instalacion
DEST_SERVICE_FILE="/etc/systemd/system/glassfish4.service" # Ubicacion del archivo de servicio systemd

# Variable para el directorio SSL (debe coincidir con el script setup_ssl.sh)
SSL_DIR="/etc/glassfish/ssl"

# Comprobar si el script se ejecuta como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse como root. Por favor, use sudo."
    exit 1
fi

# Comprobar si se ejecutó a través de sudo y obtener el usuario original
# Esto es NECESARIO para limpiar el .bashrc del usuario correcto.
if [ -z "$SUDO_USER" ]; then
    echo "Advertencia: No se detectó SUDO_USER. Asumiendo ejecución directa como root."
    echo "Se desinstalarán los archivos del sistema y el servicio, pero NO se modificará el .bashrc de ningún usuario."
    # Establecer valores ficticios para saltar la sección de modificación de bashrc
    ORIGINAL_USER="root"
    USER_HOME="/root"
else
    ORIGINAL_USER="$SUDO_USER"
    # Obtener el directorio home del usuario original
    USER_HOME=$(getent passwd "$ORIGINAL_USER" | cut -d: -f6)

    if [ -z "$USER_HOME" ]; then
        echo "Error: No se pudo determinar el directorio home para el usuario '$ORIGINAL_USER'."
        echo "La desinstalación de archivos y servicio continuará, pero NO se modificará el .bashrc."
        # Establecer valores ficticios para saltar la sección de modificación de bashrc
         ORIGINAL_USER="root"
         USER_HOME="/root"
    else
        echo "Usuario original detectado para limpieza de .bashrc: $ORIGINAL_USER"
    fi
fi

echo "--- Iniciando Proceso de Desinstalación ---"

# Eliminar el directorio de GlassFish si existe
if [ -d "$GLASSFISH_HOME" ]; then
    echo "Desinstalando GlassFish ${GLASSFISH_VERSION} server del directorio ${GLASSFISH_HOME}..."

    # Intentar detener el servidor GlassFish (usando ambos metodos originales)
    echo "Intentando detener GlassFish server..."
    if pgrep -f "glassfish4" > /dev/null; then
        echo "Proceso GlassFish detectado. Intentando detener via systemd y asadmin..."
        # Detener via systemd (si el servicio existe y esta activo)
        if systemctl is-active glassfish4.service &> /dev/null; then
             systemctl stop glassfish4.service || echo "Advertencia: Falló la detención del servicio glassfish4.service via systemd."
        fi
        # Detener via asadmin directamente (redundante si systemd funciona, pero se mantiene por script original)
        "$GLASSFISH_HOME"/bin/asadmin stop-domain || echo "Advertencia: Falló la detención del dominio via asadmin."
        sleep 5 # Dar tiempo a que los procesos terminen

        # Verificar si todavia hay procesos GlassFish
         if pgrep -f "glassfish4" > /dev/null; then
            echo "Advertencia: Procesos GlassFish todavia ejecutandose despues de intentar detener. Pueden requerir detencion manual."
         else
             echo "Procesos GlassFish detenidos (o no estaban ejecutandose inicialmente)."
         fi

    else
        echo "No se detectaron procesos GlassFish ejecutandose."
    fi

    # Eliminar el directorio de instalacion
    echo "Eliminando directorio de instalación: ${GLASSFISH_HOME}..."
    rm -rf "$GLASSFISH_HOME" || {
        echo "Error: Falló la eliminación del directorio ${GLASSFISH_HOME}. Puede que necesite eliminarlo manualmente."
        # No salimos, permitimos limpiar bashrc y servicio
    }
else
    echo "Directorio de instalación ${GLASSFISH_HOME} no encontrado. Nada que eliminar en esta ubicación."
fi

# --- NUEVA SECCIÓN: Eliminar el directorio SSL si existe en /etc ---
if [ -d "$SSL_DIR" ]; then
    echo "Eliminando directorio de configuracion SSL en /etc: ${SSL_DIR}..."
    rm -rf "$SSL_DIR" || {
        echo "Advertencia: Falló la eliminación del directorio ${SSL_DIR}. Puede que necesite eliminarlo manualmente."
    }
else
    echo "Directorio de configuracion SSL ${SSL_DIR} no encontrado. Nada que eliminar en /etc."
fi
# --- FIN NUEVA SECCIÓN ---


# Eliminar servicio systemd glassfish4.service si existe
if [ -f "$DEST_SERVICE_FILE" ]; then
    echo "Eliminando servicio systemd ${DEST_SERVICE_FILE}..."
    # Deshabilitar el servicio antes de eliminar el archivo
    if systemctl is-enabled glassfish4.service &> /dev/null; then
        echo "Deshabilitando servicio glassfish4.service..."
        systemctl disable glassfish4.service || echo "Advertencia: Falló la deshabilitación del servicio glassfish4.service."
    fi
    # Eliminar el archivo de servicio
    rm "$DEST_SERVICE_FILE" || echo "Advertencia: Falló la eliminación del archivo de servicio ${DEST_SERVICE_FILE}. Elimine manualmente si es necesario."
    # Recargar daemon de systemd
    echo "Recargando daemon de systemd..."
    systemctl daemon-reload || echo "Advertencia: Falló systemctl daemon-reload."
else
    echo "Archivo de servicio ${DEST_SERVICE_FILE} no encontrado. Nada que eliminar."
fi


# Eliminar variables de entorno del bashrc del USUARIO ORIGINAL
# Solo intentar si se identifico un usuario valido con un directorio home
if [ -n "$USER_HOME" ] && [ "$ORIGINAL_USER" != "root" ]; then
    USER_BASHRC="${USER_HOME}/.bashrc"

    if [ -f "$USER_BASHRC" ]; then
        echo "Eliminando variables de entorno de GlassFish de $USER_BASHRC para el usuario $ORIGINAL_USER..."

        # Patrones para las lineas exactas que el script de instalacion anadio
        # Escapamos las barras diagonales en las rutas para sed
        GLASSFISH_HOME_LINE="^export GLASSFISH_HOME=${GLASSFISH_HOME//\//\\/}"
        PATH_LINE="^export PATH=\\\$PATH:\${GLASSFISH_HOME//\//\\/}\/bin"

        # Usamos grep -q para verificar si alguna de las lineas existe antes de intentar sed
        if grep -q "$GLASSFISH_HOME_LINE" "$USER_BASHRC" 2>/dev/null || \
           grep -q "$PATH_LINE" "$USER_BASHRC" 2>/dev/null; then

            # Eliminar las líneas exactas añadidas por el script de instalación
            # Usamos -i para editar el archivo en su lugar
            # Usamos -e para especificar multiples comandos de eliminacion
            sed -i -e "/${GLASSFISH_HOME_LINE}/d" -e "/${PATH_LINE}/d" "$USER_BASHRC"
            echo "Variables de entorno eliminadas de $USER_BASHRC."
        else
            echo "Las variables de entorno de GlassFish no se encontraron (o no coinciden) en $USER_BASHRC."
            echo "Puede que necesite eliminarlas manualmente si fueron añadidas de otra forma."
        fi
    else
        echo "El archivo .bashrc para el usuario ${ORIGINAL_USER} no existe en ${USER_HOME}. Nada que limpiar."
    fi
else
    echo "Saltando limpieza de .bashrc. No se pudo identificar un usuario válido para modificar o el script no se ejecutó con sudo."
    echo "Si configuró variables de entorno manualmente, necesitará eliminarlas usted mismo."
fi


echo "--- Desinstalación de GlassFish ${GLASSFISH_VERSION} Completada ---"

# Mensaje final sobre variables de entorno
if [ -n "$USER_HOME" ] && [ "$ORIGINAL_USER" != "root" ]; then
     echo "Para que los cambios (eliminacion de variables de entorno) surtan efecto en la terminal del usuario ${ORIGINAL_USER},"
     echo "este usuario debe ejecutar:"
     echo "source ${USER_BASHRC}"
     echo "o abrir una nueva ventana de terminal."
else
     echo "Si modificó manualmente sus variables de entorno, necesitará eliminarlas y recargar su terminal."
fi
