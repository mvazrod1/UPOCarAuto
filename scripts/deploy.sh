#!/bin/bash

# Script para desplegar (o redesplegar) aplicaciones Java EE y WS en GlassFish 4.1.1
# Modificado para usar 'redeploy' y permitir la actualizacion de apps existentes,
# especificando explicitamente el nombre de la aplicacion para evitar el prompt.
# Uso: ./deploy.sh <ruta_archivo_war_WS> <ruta_archivo_war>

# Comprobar si se proporciona el numero correcto de argumentos
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <ruta_archivo_war_WS> <ruta_archivo_war>"
    exit 1
fi

# Asignar argumentos a variables
# Se usan comillas para mayor robustez, aunque tu original no las tenia.
# Si quieres SER estrictamente minimalista como el original, quita las comillas.
WS_WAR_FILE="$1"
WAR_FILE="$2"


# Comprobar si el servidor GlassFish ya esta instalado
if [ ! -d "/opt/glassfish4" ]; then
    echo "Servidor GlassFish no encontrado. Por favor, instale primero GlassFish 4.1.1."
    exit 1
fi

# Comprobar si el servidor GlassFish esta ejecutandose
if ! pgrep -f "glassfish4" > /dev/null; then
    echo "Iniciando servidor GlassFish..."
    # Podrias necesitar añadir un '&' y 'sleep' aqui si el script continua antes de que GF este listo.
    /opt/glassfish4/bin/asadmin start-domain
else
    echo "El servidor GlassFish ya esta ejecutandose."
fi

# Obtener el nombre del archivo WAR de WS (sin ruta ni extension)
WS_APP_NAME=$(basename "$WS_WAR_FILE" .war)
echo "Realizando redepliegue de la aplicacion WS con nombre: $WS_APP_NAME desde: $WS_WAR_FILE"
# *** MODIFICACION: Añadir --name con el nombre de la app ***
/opt/glassfish4/bin/asadmin redeploy --name "$WS_APP_NAME" "$WS_WAR_FILE"

# Comprobar si el redepliegue de WS fue exitoso
if [ $? -ne 0 ]; then
    echo "Falló el redepliegue de la aplicacion WS '$WS_APP_NAME'."
    exit 1
fi
echo "Redepliegue de la aplicacion WS '$WS_APP_NAME' completado."

# Obtener el nombre del archivo WAR principal (sin ruta ni extension)
MAIN_APP_NAME=$(basename "$WAR_FILE" .war)
echo "Realizando redepliegue de la aplicacion Java EE con nombre: $MAIN_APP_NAME desde: $WAR_FILE"
# *** MODIFICACION: Añadir --name con el nombre de la app ***
/opt/glassfish4/bin/asadmin redeploy --name "$MAIN_APP_NAME" --contextroot "/" "$WAR_FILE"

# Comprobar si el redepliegue de Java EE fue correcto
if [ $? -ne 0 ]; then
    echo "Falló el redepliegue de la aplicacion Java EE '$MAIN_APP_NAME'."
    exit 1
fi
echo "Redepliegue de la aplicacion Java EE '$MAIN_APP_NAME' completado."

echo "Ambas aplicaciones redeployadas exitosamente."