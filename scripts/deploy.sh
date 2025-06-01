#!/bin/bash

# Script para desplegar una aplicacion Java EE y una aplicacion WS en GlassFish 4.1.1
# Modificado para usar 'deploy --force' y permitir la actualizacion de apps existentes.
# Uso: ./deploy.sh <ruta_archivo_war_WS> <ruta_archivo_war>

# Comprobar si se proporciona el numero correcto de argumentos
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <ruta_archivo_war_WS1> <ruta_archivo_war_WS2> <ruta_archivo_war>"
    exit 1
fi
# Asignar argumentos a variables
# Se usan comillas para mayor robustez, aunque tu original no las tenia. Mantengamos las comillas.
WS_WAR_FILE1="$1"
WS_WAR_FILE2="$2"
WAR_FILE="$3"
# Comprobar si el servidor GlassFish ya esta instalado
if [ ! -d "/opt/glassfish4" ]; then
    echo "Servidor GlassFish no encontrado. Por favor, instale primero GlassFish 4.1.1."
    exit 1
fi

# Comprobar si el servidor GlassFish esta ejecutandose
if ! pgrep -f "glassfish4" > /dev/null; then
    echo "Iniciando servidor GlassFish..."
    /opt/glassfish4/bin/asadmin start-domain
    # Es CRÍTICO añadir un sleep aquí si el start-domain no espera a que GF esté listo.
    # Si el deploy falla justo después del inicio, es probable que GlassFish no esté operativo todavía.
    echo "Esperando unos segundos a que GlassFish esté completamente listo..."
    sleep 15 # Ajusta este tiempo si es necesario para tu sistema.
else
    echo "El servidor GlassFish ya esta ejecutandose."
fi

# Desplegar (o forzar redepliegue/actualizacion) la aplicacion WS
echo "Desplegando aplicacion WS $1 (forzando actualizacion si existe)..."
# *** MODIFICACION CLAVE: Añadir '--force' para permitir sobrescribir si ya existe ***
/opt/glassfish4/bin/asadmin deploy --force "$WS_WAR_FILE1"
# Comprobar si el despliegue fue exitoso
if [ $? -ne 0 ]; then
    echo "Falló el despliegue (forzado) de la aplicacion WS."
    exit 1
fi

# Desplegar (o forzar redepliegue/actualizacion) la aplicacion WS
echo "Desplegando aplicacion WS $2 (forzando actualizacion si existe)..."
# *** MODIFICACION CLAVE: Añadir '--force' para permitir sobrescribir si ya existe ***
/opt/glassfish4/bin/asadmin deploy --force "$WS_WAR_FILE2"
# Comprobar si el despliegue fue exitoso
if [ $? -ne 0 ]; then
    echo "Falló el despliegue (forzado) de la aplicacion WS."
    exit 1
fi

# Desplegar (o forzar redepliegue/actualizacion) la aplicacion Java EE
echo "Desplegando aplicacion Java EE (forzando actualizacion si existe)..."
# *** MODIFICACION CLAVE: Añadir '--force' para permitir sobrescribir si ya existe ***
/opt/glassfish4/bin/asadmin deploy --force --contextroot "/" "$WAR_FILE"
# Comprobar si el despliegue fue correcto
if [ $? -ne 0 ]; then
    echo "Falló el despliegue (forzado) de la aplicacion Java EE."
    exit 1
fi
echo "Aplicaciones desplegadas/actualizadas exitosamente usando --force."