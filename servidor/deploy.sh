#!/bin/bash

# Script para desplegar una aplicacion Java EE y una aplicacion WS en GlassFish 4.1.1
# Uso: ./deploy.sh <ruta_archivo_war_WS> <ruta_archivo_war>

# Comprobar si se proporciona el numero correcto de argumentos
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <ruta_archivo_war_WS> <ruta_archivo_war>"
    exit 1
fi
# Asignar argumentos a variables
WS_WAR_FILE=$1
WAR_FILE=$2
# Comprobar si el servidor GlassFish ya esta instalado
if [ ! -d "/opt/glassfish4" ]; then
    echo "Servidor GlassFish no encontrado. Por favor, instale primero GlassFish 4.1.1."
    exit 1
fi
# Comprobar si el servidor GlassFish esta ejecutandose
if ! pgrep -f "glassfish4" > /dev/null; then
    echo "Iniciando servidor GlassFish..."
    /opt/glassfish4/bin/asadmin start-domain
else
    echo "El servidor GlassFish ya esta ejecutandose."
fi
# Desplegar la aplicacion WS
echo "Desplegando aplicacion WS..."
/opt/glassfish4/bin/asadmin deploy $WS_WAR_FILE
# Comprobar si el despliegue fue exitoso
if [ $? -ne 0 ]; then
    echo "Falló el despliegue de la aplicacion WS."
    exit 1
fi
# Desplegar la aplicacion Java EE
echo "Desplegando aplicacion Java EE..."
/opt/glassfish4/bin/asadmin deploy --contextroot "/" $WAR_FILE
# Comprobar si el despliegue fue correcto
if [ $? -ne 0 ]; then
    echo "Falló el despliegue de la aplicacion Java EE."
    exit 1
fi
echo "Aplicaciones desplegadas exitosamente."