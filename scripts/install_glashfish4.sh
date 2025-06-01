#!/bin/bash

# Este script debe ejecutarse con privilegios de root
# Script para instalar GlassFish 4.1.1 en ubuntu 24.04
# Este script descargará e instalará GlassFish 4.1.1 si no está ya instalado.
# Tambien instala las variables de entorno en el .bashrc del usuario que ejecuta sudo.
# Copia, instala y habilita el servicio systemd desde el archivo glassfish4.service
# esperado en el directorio actual.
# Comprueba e instala wget y unzip si es necesario.
# Crea el dominio por defecto 'domain1' de GlassFish.
# Uso: Ejecutar este script con sudo desde el directorio que contiene glassfish-4.1.1.zip Y glassfish4.service (si este ultimo existe)
# Ejemplo: sudo bash ./install_glashfish4.sh

# Definir variables
GLASSFISH_VERSION="4.1.1"
GLASSFISH_ZIP="glassfish-${GLASSFISH_VERSION}.zip"
INSTALL_DIR="/opt"
GLASSFISH_HOME="${INSTALL_DIR}/glassfish4" # El zip se extrae en una carpeta 'glassfish4'

# Configuración del dominio
DEFAULT_DOMAIN_NAME="domain1"
GLASSFISH_DOMAIN_DIR="${GLASSFISH_HOME}/domains/${DEFAULT_DOMAIN_NAME}" # Ruta donde se creara el dominio
# La contraseña para el administrador del dominio (usuario por defecto 'admin')
# ¡CAMBIA ESTO Y CONSIDERA LAS IMPLICACIONES DE SEGURIDAD!
# Usamos la variable PASSWORD que ya existía en el script.
PASSWORD="upo"


# Archivos de servicio systemd
SOURCE_SERVICE_FILE="./glassfish4.service" # Archivo de servicio esperado en el directorio actual
DEST_SERVICE_FILE="/etc/systemd/system/glassfish4.service" # Ubicacion de destino en systemd

echo "--- Instalación y Configuración Inicial de GlassFish ---"
echo "Versión: ${GLASSFISH_VERSION}"
echo "Directorio de Instalación: ${INSTALL_DIR}"
echo "GlassFish HOME: ${GLASSFISH_HOME}"
echo "Dominio por defecto: ${DEFAULT_DOMAIN_NAME}"
echo "Directorio del Dominio: ${GLASSFISH_DOMAIN_DIR}"
echo "--- Iniciando Proceso ---"


# Comprobar si el script se ejecuta como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse como root. Por favor, use sudo."
    exit 1
fi

# Comprobar si se ejecutó a través de sudo y obtener el usuario original
# Necesitamos el usuario original para modificar su .bashrc
if [ -z "$SUDO_USER" ]; then
    echo "Error: Este script debe ejecutarse usando 'sudo', no directamente como root."
    echo "Ejemplo: sudo bash $(basename "$0")"
    exit 1
fi

ORIGINAL_USER="$SUDO_USER"
# Obtener el directorio home del usuario original
USER_HOME=$(getent passwd "$ORIGINAL_USER" | cut -d: -f6)

# Comprobar si el servidor GlassFish ya está instalado (verifica la carpeta extraida)
if [ -d "$GLASSFISH_HOME" ]; then
    echo "Servidor GlassFish encontrado en $GLASSFISH_HOME. Saltando instalación de archivos."

    # Comprobar y añadir variables de entorno si faltan (para el usuario original)
    if [ -n "$USER_HOME" ]; then # Solo si se encontro un directorio home valido
        USER_BASHRC="${USER_HOME}/.bashrc"
        # Comprobar si la linea de GLASSFISH_HOME ya existe en el bashrc del usuario original
        if ! grep -q "GLASSFISH_HOME=${GLASSFISH_HOME}" "$USER_BASHRC" 2>/dev/null; then
             echo "GlassFish instalado, pero variables de entorno no encontradas en $USER_BASHRC para $ORIGINAL_USER."
             echo "Configurando variables de entorno..."
              # Añadir las variables de entorno al .bashrc del usuario original
             echo "" >> "$USER_BASHRC" # Añadir una línea en blanco para separación
             echo "export GLASSFISH_HOME=${GLASSFISH_HOME}" >> "$USER_BASHRC"
             echo "export PATH=\$PATH:\${GLASSFISH_HOME}/bin" >> "$USER_BASHRC"
             echo "" >> "$USER_BASHRC" # Añadir otra línea en blanco
             echo "Variables de entorno añadidas a $USER_BASHRC."
             echo "Ejecute 'source $USER_BASHRC' o reinicie su terminal para que surtan efecto."
        else
            echo "Variables de entorno para GlassFish encontradas en $USER_BASHRC."
        fi
    else
        echo "No se pudo determinar el directorio home para el usuario '$ORIGINAL_USER'."
        echo "Las variables de entorno no se configuraron automáticamente."
        echo "Es posible que necesite añadir manualmente GLASSFISH_HOME y \$GLASSFISH_HOME/bin a su PATH."
    fi

    # Comprobar si el servicio systemd ya está habilitado
     if systemctl is-enabled glassfish4.service &> /dev/null; then
        echo "Servicio glassfish4.service ya habilitado. Saltando configuración del servicio."
     else
        # Si GlassFish esta instalado pero el servicio no esta habilitado, intentar crearlo y habilitarlo
         echo "GlassFish instalado, pero servicio systemd no habilitado."
         # Comprobar si el archivo de servicio fuente existe antes de intentar usarlo
         if [ ! -f "$SOURCE_SERVICE_FILE" ]; then
             echo "Error: El archivo de servicio systemd '${SOURCE_SERVICE_FILE}' NO se encontró en el directorio actual ($(pwd))."
             echo "No se puede configurar el servicio systemd GlassFish sin este archivo."
         else
             echo "Archivo de servicio '${SOURCE_SERVICE_FILE}' encontrado."
             echo "Copiando archivo de servicio a ${DEST_SERVICE_FILE}..."
             cp "$SOURCE_SERVICE_FILE" "$DEST_SERVICE_FILE" || {
                 echo "Error: Falló la copia del archivo de servicio a ${DEST_SERVICE_FILE}. Verifique permisos."
             }

             echo "Recargando daemon de systemd..."
             systemctl daemon-reload || echo "Advertencia: Falló systemctl daemon-reload."

             echo "Habilitando servicio glassfish4.service para inicio automático..."
             systemctl enable glassfish4.service || echo "Advertencia: Falló systemctl enable glassfish4.service."
             echo "Puede iniciar el servicio con: sudo systemctl start glassfish4.service"
         fi
     fi

    # **NUEVA VERIFICACION: Comprobar si el dominio por defecto ya existe**
    if [ -d "$GLASSFISH_DOMAIN_DIR" ]; then
        echo "El dominio GlassFish por defecto (${DEFAULT_DOMAIN_NAME}) ya existe en $GLASSFISH_DOMAIN_DIR. Saltando creación del dominio."
    else
        # Si GlassFish está instalado pero el dominio no existe, intentar crearlo.
        echo "GlassFish instalado, pero el dominio por defecto (${DEFAULT_DOMAIN_NAME}) no se encontró."
        echo "Intentando crear el dominio por defecto..."

        # Crear archivo de contraseña temporal para asadmin (para la contraseña del ADMIN)
        PASSWORD_FILE=$(mktemp)
        echo "$PASSWORD" > "$PASSWORD_FILE"
        chmod 600 "$PASSWORD_FILE" # Asegurar que solo el propietario puede leerlo

        # Ejecutar create-domain usando el archivo de contraseña
        # Usa el usuario 'admin' por defecto y puertos por defecto 8080, 8181, 4848
        echo "Ejecutando asadmin create-domain ${DEFAULT_DOMAIN_NAME}..."
        "$GLASSFISH_HOME"/bin/asadmin create-domain \
            --passwordfile "$PASSWORD_FILE" \
            "${DEFAULT_DOMAIN_NAME}"

        # Limpiar archivo de contraseña temporal
        rm "$PASSWORD_FILE"

        if [ $? -ne 0 ]; then
            echo "Error: Falló la creación del dominio GlassFish '${DEFAULT_DOMAIN_NAME}'."
            echo "Puede que necesite crearlo manualmente ejecutando:"
            echo "sudo ${GLASSFISH_HOME}/bin/asadmin create-domain ${DEFAULT_DOMAIN_NAME}"
            # No salimos, permitimos que el resto del script (como la configuración del servicio) continúe
        else
            echo "Dominio GlassFish '${DEFAULT_DOMAIN_NAME}' creado exitosamente en ${GLASSFISH_DOMAIN_DIR}."
        fi
    fi

    exit 0 # Salir si ya está instalado (archivos) y se manejó la creación del dominio si faltaba
fi

# Comprobar si el directorio /opt existe, si no, crearlo
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Creando directorio $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR" || {
        echo "Error: No se pudo crear el directorio $INSTALL_DIR. Verifique permisos."
        exit 1
    }
else
    echo "Directorio de instalación $INSTALL_DIR ya existe."
fi

# Comprobar si existen wget y unzip, instalarlos si no
if ! command -v wget &> /dev/null || ! command -v unzip &> /dev/null; then
    echo "Herramientas requeridas (wget o unzip) no encontradas. Instalando..."
    apt-get update -y || echo "Advertencia: Falló apt update antes de instalar herramientas."
    if ! command -v wget &> /dev/null; then
        echo "Instalando wget..."
        apt-get install wget -y || { echo "Error instalando wget."; exit 1; }
    fi
    if ! command -v unzip &> /dev/null; then
        echo "Instalando unzip..."
        apt-get install unzip -y || { echo "Error instalando unzip."; exit 1; }
    fi
fi

# Si no existe el fichero zip en el directorio ., se descarga el servidor GlassFish 4.1.1
if [ ! -f "./$GLASSFISH_ZIP" ]; then
    echo "Archivo zip de GlassFish '$GLASSFISH_ZIP' no encontrado en el directorio actual ($(pwd)). Descargando..."
    wget -c "http://download.oracle.com/glassfish/${GLASSFISH_VERSION}/release/${GLASSFISH_ZIP}" || {
        echo "Error: Falló la descarga de ${GLASSFISH_ZIP}. Por favor, compruebe su conexión a internet y la URL."
        exit 1
    }
else
    echo "Archivo zip de GlassFish '$GLASSFISH_ZIP' encontrado en el directorio actual ($(pwd)). Saltando descarga."
fi

# extraer el fichero zip en /opt/ usando un parametro de unzip
echo "Extrayendo GlassFish ${GLASSFISH_VERSION} en ${INSTALL_DIR}..."
unzip -o "./${GLASSFISH_ZIP}" -d "$INSTALL_DIR" || {
    echo "Error: Falló la extracción de ${GLASSFISH_ZIP} en ${INSTALL_DIR}. Por favor, compruebe el archivo descargado y permisos."
    exit 1
}

# establecer permisos - Usar root:root es el estandar para archivos en /opt
echo "Estableciendo propiedad de ${GLASSFISH_HOME} a root:root..."
chown -R root:root "$GLASSFISH_HOME" || echo "Advertencia: Falló el establecimiento de propiedad root:root en ${GLASSFISH_HOME}."


# --- Crear el Dominio GlassFish por Defecto ---
echo "Creando el dominio GlassFish por defecto (${DEFAULT_DOMAIN_NAME})..."

# Crear archivo de contraseña temporal para asadmin (para la contraseña del ADMIN)
PASSWORD_FILE=$(mktemp)
echo "$PASSWORD" > "$PASSWORD_FILE"
chmod 600 "$PASSWORD_FILE" # Asegurar que solo el propietario puede leerlo

# Ejecutar create-domain usando el archivo de contraseña
# Usa el usuario 'admin' por defecto y puertos por defecto 8080, 8181, 4848
echo "Ejecutando asadmin create-domain ${DEFAULT_DOMAIN_NAME}..."
"$GLASSFISH_HOME"/bin/asadmin create-domain \
    --passwordfile "$PASSWORD_FILE" \
    "${DEFAULT_DOMAIN_NAME}"

# Limpiar archivo de contraseña temporal
rm "$PASSWORD_FILE"

if [ $? -ne 0 ]; then
    echo "Error: Falló la creación del dominio GlassFish '${DEFAULT_DOMAIN_NAME}'."
    echo "Deberá crearlo manualmente después. Comando: sudo ${GLASSFISH_HOME}/bin/asadmin create-domain ${DEFAULT_DOMAIN_NAME}"
    exit 1 # Salir si la creación del dominio falla después de una nueva instalación
else
    echo "Dominio GlassFish '${DEFAULT_DOMAIN_NAME}' creado exitosamente en ${GLASSFISH_DOMAIN_DIR}."
fi


# --- Configurar Variables de Entorno para el Usuario Original ---
# Solo proceder si se encontró un usuario y directorio home valido
if [ -n "$USER_HOME" ]; then
    USER_BASHRC="${USER_HOME}/.bashrc"

    echo "Configurando variables de entorno en $USER_BASHRC para el usuario $ORIGINAL_USER..."

    # Comprobar si la linea de GLASSFISH_HOME ya existe para evitar duplicados
    # Usamos 2>/dev/null para suprimir errores si el archivo .bashrc no existe
    if grep -q "GLASSFISH_HOME=${GLASSFISH_HOME}" "$USER_BASHRC" 2>/dev/null; then
        echo "Las variables de entorno de GlassFish ya existen en $USER_BASHRC."
    else
        # Añadir las variables de entorno al .bashrc del usuario original
        echo "" >> "$USER_BASHRC" # Añadir una línea en blanco para separación
        echo "export GLASSFISH_HOME=${GLASSFISH_HOME}" >> "$USER_BASHRC"
        echo "export PATH=\$PATH:\${GLASSFISH_HOME}/bin" >> "$USER_BASHRC"
        echo "" >> "$USER_BASHRC" # Añadir otra línea en blanco

        echo "Variables de entorno añadidas a $USER_BASHRC."
        echo "Ejecute 'source ${USER_BASHRC}' o reinicie su terminal para que surtan efecto."
    fi
else
    echo "Saltando configuración de .bashrc. No se pudo identificar un usuario válido para modificar."
    echo "Es posible que necesite añadir manualmente GLASSFISH_HOME y \$GLASSFISH_HOME/bin a su PATH."
fi

# --- Instalar y Habilitar Servicio Systemd ---
# Comprobar si el archivo de servicio fuente existe antes de intentar usarlo
if [ ! -f "$SOURCE_SERVICE_FILE" ]; then
    echo "Error: El archivo de servicio systemd '${SOURCE_SERVICE_FILE}' NO se encontró en el directorio actual ($(pwd))."
    echo "No se puede configurar el servicio systemd GlassFish sin este archivo."
    echo "Por favor, coloque el archivo '${SOURCE_SERVICE_FILE}' junto al script de instalación."
    # No salimos aquí para permitir que la instalación de archivos GlassFish y variables de entorno se complete.
    # El usuario simplemente tendrá que configurar el servicio manualmente después.
else
    # Comprobar si el servicio systemd ya está habilitado
    if systemctl is-enabled glassfish4.service &> /dev/null; then
       echo "Servicio glassfish4.service ya habilitado. Saltando configuración del servicio."
    else
        echo "Archivo de servicio '${SOURCE_SERVICE_FILE}' encontrado."
        echo "Copiando archivo de servicio a ${DEST_SERVICE_FILE}..."
        # Usamos cp para copiar el archivo fuente
        cp "$SOURCE_SERVICE_FILE" "$DEST_SERVICE_FILE" || {
            echo "Error: Falló la copia del archivo de servicio a ${DEST_SERVICE_FILE}. Verifique permisos."
            echo "La configuración del servicio systemd no pudo completarse."
            # No salimos, permitimos que el resto del script termine
        }

        # Solo intentar habilitar y recargar si la copia tuvo exito
        if [ -f "$DEST_SERVICE_FILE" ]; then
            echo "Recargando daemon de systemd..."
            systemctl daemon-reload || echo "Advertencia: Falló systemctl daemon-reload."

            echo "Habilitando servicio glassfish4.service para inicio automático..."
            systemctl enable glassfish4.service || echo "Advertencia: Falló systemctl enable glassfish4.service."
            echo "Puede iniciar el servicio con: sudo systemctl start glassfish4.service"
        else
            echo "Advertencia: El archivo de servicio de destino ${DEST_SERVICE_FILE} no existe después de intentar copiarlo."
        fi
    fi
fi


# --- Finalización ---
echo "--- Instalación de GlassFish ${GLASSFISH_VERSION} y Dominio Completada ---"
echo "GlassFish está instalado en ${GLASSFISH_HOME}."
echo "El dominio '${DEFAULT_DOMAIN_NAME}' ha sido creado en ${GLASSFISH_DOMAIN_DIR}."

# Mensaje sobre variables de entorno solo si fueron modificadas
if [ -n "$USER_HOME" ]; then
    echo "Variables de entorno añadidas a ${USER_BASHRC} para el usuario ${ORIGINAL_USER}."
    echo "Para aplicar las variables en su terminal actual, ejecute: source ${USER_BASHRC}"
else
     echo "Recuerde añadir manualmente GLASSFISH_HOME y \$GLASSFISH_HOME/bin a su PATH."
     echo "Ejemplo:"
     echo "export GLASSFISH_HOME=${GLASSFISH_HOME}"
     echo "export PATH=\$PATH:\${GLASSFISH_HOME}/bin"
fi

# Mensaje sobre el servicio solo si se intentó configurar
if [ -f "$SOURCE_SERVICE_FILE" ]; then
    echo "Puede verificar el estado del servicio con: sudo systemctl status glassfish4.service"
    echo "Puede iniciar el servicio con: sudo systemctl start glassfish4.service"
else
    echo "El archivo de servicio systemd no se configuró automáticamente porque '${SOURCE_SERVICE_FILE}' no se encontró."
    echo "Necesitará crear y habilitar el servicio manualmente si lo desea."
fi # Corregido 'end' por 'fi' aquí

echo "La consola de administración por defecto es accesible en http://localhost:4848"
echo "El listener HTTP por defecto es accesible en http://localhost:8080"
echo "El listener HTTPS por defecto es accesible en https://localhost:8181 (requiere configuración SSL adicional)"


exit 0