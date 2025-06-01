#!/bin/bash

# Define variables para versiones y rutas
JDK_VERSION_DIR="jdk1.8.0_281"
JDK_TARBALL="jdk-8u281-linux-x64.tar.gz"
INSTALL_DIR="/usr/lib/jvm"
JDK_FULL_PATH="${INSTALL_DIR}/${JDK_VERSION_DIR}"

# --- Verificaciones Iniciales ---

# 1. Comprobar si el script se ejecuta como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: Este script debe ejecutarse con privilegios de root. Por favor, use 'sudo bash $(basename "$0")'."
    exit 1
fi

# 2. Comprobar si se ejecutó a través de sudo y obtener el usuario original
# SUDO_USER es la variable que contiene el nombre de usuario original cuando se usa sudo
if [ -z "$SUDO_USER" ]; then
    echo "Error: Este script debe ejecutarse usando 'sudo', no directamente como root."
    echo "Ejemplo: sudo bash $(basename "$0")"
    exit 1
fi

ORIGINAL_USER="$SUDO_USER"
# Obtener el directorio home del usuario original
# getent passwd $ORIGINAL_USER extrae la línea del usuario del archivo de contraseñas
# cut -d: -f6 extrae el sexto campo, que es el directorio home
USER_HOME=$(getent passwd "$ORIGINAL_USER" | cut -d: -f6)

if [ -z "$USER_HOME" ]; then
    echo "Error: No se pudo determinar el directorio home para el usuario '$ORIGINAL_USER'."
    echo "Por favor, asegúrese de que el usuario '$ORIGINAL_USER' existe y tiene un directorio home configurado."
    exit 1
fi

USER_BASHRC="${USER_HOME}/.bashrc"

echo "--- Configuración de Instalación ---"
echo "Usuario original detectado: $ORIGINAL_USER"
echo "Directorio home del usuario: $USER_HOME"
echo "Archivo .bashrc del usuario: $USER_BASHRC"
echo "Ruta de instalación del JDK: $JDK_FULL_PATH"
echo "--- Iniciando Proceso de Instalación ---"


# 3. Comprobar si el JDK ya está instalado en la ruta esperada
if [ -d "$JDK_FULL_PATH" ]; then
    echo "El JDK $JDK_VERSION_DIR ya parece estar instalado en $JDK_FULL_PATH."
    # Aunque ya esté instalado, podríamos querer reconfigurar las alternativas por si acaso.
    # Si prefieres salir, descomenta la siguiente línea:
    # exit 0

    # Si no salimos, continuaremos para asegurar que las alternativas estén configuradas.
    echo "Verificando/configurando las alternativas del sistema para este JDK existente..."
fi

# 4. Comprobar si el archivo tar.gz existe solo si el JDK NO estaba ya instalado y decidimos no salir
if [ ! -d "$JDK_FULL_PATH" ]; then # Solo hacemos esta verificación si NO encontramos el JDK
    if [ ! -f "./$JDK_TARBALL" ]; then
        echo "Error: El archivo $JDK_TARBALL no se encontró en el directorio actual ($(pwd))."
        echo "Por favor, asegúrese de que el archivo está en el mismo directorio que el script '$0'."
        exit 1
    fi

    # --- Proceso de Instalación (solo si el JDK no estaba) ---

    echo "Archivo $JDK_TARBALL encontrado."
    echo "Creando directorio de instalación si no existe: $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR" # Crea el directorio y padres si no existen
    if [ $? -ne 0 ]; then
        echo "Error: No se pudo crear el directorio $INSTALL_DIR. Verifique permisos."
        exit 1
    fi

    echo "Extrayendo $JDK_TARBALL en $INSTALL_DIR..."
    if tar -xzf "./$JDK_TARBALL" -C "$INSTALL_DIR" --no-same-owner --no-same-permissions; then
        echo "$JDK_TARBALL extraído correctamente."
    else
        echo "Error: Falló la extracción de $JDK_TARBALL."
        echo "Verifique que el archivo no esté corrupto y tenga permisos de lectura."
        exit 1
    fi
else
    # Mensaje si el JDK ya estaba y continuamos
    echo "Saltando extracción, JDK ya presente."
fi


# --- Configurar Variables de Entorno para el Usuario Original ---
# Esto siempre se ejecuta, incluso si el JDK ya estaba instalado.

echo "Configurando variables de entorno en el archivo $USER_BASHRC para el usuario $ORIGINAL_USER..."

if grep -q "export JAVA_HOME=${JDK_FULL_PATH}" "$USER_BASHRC" 2>/dev/null && \
   grep -q "export PATH=\$PATH:\$JAVA_HOME/bin" "$USER_BASHRC" 2>/dev/null; then
    echo "Las variables de entorno para este JDK ya existen en $USER_BASHRC."
else
    echo "" >> "$USER_BASHRC"
    echo "# >>> Configuración para Oracle JDK ${JDK_VERSION_DIR} añadida por script <<<" >> "$USER_BASHRC"
    echo "export JAVA_HOME=${JDK_FULL_PATH}" >> "$USER_BASHRC"
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> "$USER_BASHRC"
    echo "# <<< Fin Configuración Oracle JDK ${JDK_VERSION_DIR} <<<" >> "$USER_BASHRC"
    echo "" >> "$USER_BASHRC"

    echo "Variables de entorno añadidas a $USER_BASHRC."
fi

# --- Configurar Alternativas del Sistema AUTOMATICAMENTE ---
# Registramos el JDK y LO ESTABLECEMOS como la versión predeterminada del sistema.

echo "Registrando y estableciendo este JDK como la versión predeterminada del sistema usando update-alternatives..."

# Prioridad 1: Puedes ajustar la prioridad si tienes otros JDKs
# Primero, registrar la alternativa (si ya existe, update-alternatives lo maneja)
update-alternatives --install /usr/bin/java java "${JDK_FULL_PATH}/bin/java" 1
java_install_ok=$?

update-alternatives --install /usr/bin/javac javac "${JDK_FULL_PATH}/bin/javac" 1
javac_install_ok=$?

if [ $java_install_ok -ne 0 ] || [ $javac_install_ok -ne 0 ]; then
     echo "Advertencia: Falló el REGISTRO inicial del JDK con update-alternatives."
     echo "El JDK fue extraído (si no existía), pero no pudo ser registrado en el sistema de alternativas."
     # No salimos, pero avisamos que el paso crucial falló.
else
    echo "Registro con update-alternativas completado."

    # *** MODIFICACION CLAVE: Establecer este JDK como la versión predeterminada ***
    echo "Estableciendo JDK ${JDK_VERSION_DIR} (${JDK_FULL_PATH}) como la versión predeterminada del sistema..."

    update-alternatives --set java "${JDK_FULL_PATH}/bin/java"
    java_set_ok=$?

    update-alternatives --set javac "${JDK_FULL_PATH}/bin/javac"
    javac_set_ok=$?

    if [ $java_set_ok -eq 0 ] && [ $javac_set_ok -eq 0 ]; then
        echo "JDK ${JDK_VERSION_DIR} establecido exitosamente como la versión predeterminada del sistema."
    else
        echo "Advertencia: Falló el ESTABLECIMIENTO automático del JDK con update-alternatives --set."
        echo "El JDK fue registrado, pero no pudo ser establecido como predeterminado."
        echo "Puede necesitar configurarlo manualmente: 'sudo update-alternatives --config java' y 'sudo update-alternatives --config javac'."
    fi
fi


# --- Finalización ---

echo "--- Instalación/Configuración del JDK ${JDK_VERSION_DIR} completada ---"
echo "Para que las variables de entorno (JAVA_HOME, PATH) surtan efecto en su terminal actual,"
echo "ejecute el siguiente comando:"
echo "source $USER_BASHRC"
echo "Los nuevos terminales que abra cargarán la configuración automáticamente."
echo "Puede verificar la versión predeterminada del sistema ejecutando: java -version y javac -version"
echo "¡Listo para usar JDK 8!"

exit 0