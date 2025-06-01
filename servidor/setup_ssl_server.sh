#!/bin/bash
# Script para crear e instalar certificado SSL autofirmado en GlassFish y forzar HTTPS
# Ejecutar como root o con sudo

# Configuración
DOMAIN="upocarauto.sytes.net"  # Cambiar por tu dominio real
PASSWORD="upocarauto"  # Contraseña para el certificado PKCS12 (¡CAMBIA ESTO Y CONSIDERACIONES DE SEGURIDAD!)
GLASSFISH_HOME="/opt/glassfish4" # Asegúrate de que esta es la ruta correcta
SSL_DIR="/etc/glassfish/ssl"
HTTP_LISTENER="http-listener-1" # Nombre del listener HTTP por defecto (cambiar si es diferente)
HTTPS_LISTENER="http-listener-2" # Nombre del listener HTTPS por defecto (cambiar si es diferente)

# Rutas y contraseñas por defecto del Keystore/Truststore de GlassFish
# ¡VERIFICA estas rutas y especialmente la contraseña!
GLASSFISH_DOMAIN_DIR="$GLASSFISH_HOME/domains/domain1" # Asumiendo domain1
KEYSTORE_PATH="$GLASSFISH_DOMAIN_DIR/config/keystore.jks"
TRUSTSTORE_PATH="$GLASSFISH_DOMAIN_DIR/config/cacerts.jks"
KEYSTORE_PASSWORD="changeit" # !!! CAMBIA ESTO si la contraseña de tu keystore.jks es diferente

echo "--- Configuración de SSL/HTTPS para GlassFish ---"
echo "Dominio: $DOMAIN"
echo "Directorio SSL: $SSL_DIR"
echo "GlassFish Home: $GLASSFISH_HOME"
echo "Keystore GlassFish: $KEYSTORE_PATH"
echo "--- Iniciando Proceso ---"

# verficar si GlassFish está instalado y el dominio existe
if [ ! -d "$GLASSFISH_HOME" ]; then
  echo "Error: GlassFish no está instalado en $GLASSFISH_HOME. Por favor, instala GlassFish primero."
  exit 1
fi
if [ ! -d "$GLASSFISH_DOMAIN_DIR" ]; then
    echo "Error: El dominio por defecto ($GLASSFISH_DOMAIN_DIR) no se encontró. Verifique su instalación de GlassFish."
    exit 1
fi


# Crear directorios si no existen
if [ ! -d "$SSL_DIR" ]; then
  echo "Creando directorio para certificados SSL en $SSL_DIR"
  mkdir -p $SSL_DIR
  if [ $? -ne 0 ]; then
      echo "Error: No se pudo crear el directorio $SSL_DIR. Verifique permisos."
      exit 1
  fi
else
  echo "Directorio SSL ya existe: $SSL_DIR"
fi

# Verificar si ya existen los archivos principales (evitar regenerar si no es necesario)
if [ -f "$SSL_DIR/glassfish.crt" ] && [ -f "$SSL_DIR/glassfish.key" ]; then
    echo "Certificado y clave existentes encontrados en $SSL_DIR. Saltando generación."
else
    # 1. Generar certificado autofirmado
    echo "Generando certificado SSL autofirmado para $DOMAIN..."
    # Quitar 2>/dev/null para ver errores si ocurren
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
      -keyout $SSL_DIR/glassfish.key \
      -out $SSL_DIR/glassfish.crt \
      -subj "/CN=$DOMAIN/O=My Local Network/OU=GlassFish Server/C=ES"

    if [ $? -ne 0 ]; then
        echo "Error: Falló la generación del certificado SSL con OpenSSL."
        exit 1
    fi
    echo "Certificado y clave generados correctamente."
fi


# Verificar si ya existe el archivo PKCS12
if [ -f "$SSL_DIR/glassfish.p12" ]; then
     echo "Archivo PKCS12 existente encontrado en $SSL_DIR. Saltando conversión."
else
    # 2. Convertir a formato PKCS12
    echo "Convirtiendo certificado y clave a formato PKCS12..."
    # Quitar 2>/dev/null para ver errores si ocurren
    openssl pkcs12 -export -inkey $SSL_DIR/glassfish.key \
      -in $SSL_DIR/glassfish.crt \
      -out $SSL_DIR/glassfish.p12 -name "glassfish-cert" \
      -password pass:$PASSWORD

    if [ $? -ne 0 ]; then
        echo "Error: Falló la conversión a formato PKCS12."
        exit 1
    fi
    echo "Archivo PKCS12 generado correctamente."
fi


# 3. Importar certificado PKCS12 a GlassFish keystore.jks usando keytool
# Usamos la contraseña generada para el PKCS12 (-srcstorepass)
# y la contraseña del keystore.jks de GlassFish (-deststorepass)
echo "Importando certificado PKCS12 a GlassFish keystore.jks usando keytool..."

# Nota: keytool puede ser interactivo si el alias ya existe y no se usa -noprompt.
# Usamos -noprompt para evitar la interacción y -alias para especificar el alias.
# Si el alias 'glassfish-cert' ya existe en keystore.jks, este comando FALLARÁ con -noprompt.
# Una solución más robusta implicaría primero borrar el alias si existe.
keytool -importkeystore \
  -srckeystore "$SSL_DIR/glassfish.p12" \
  -srcstoretype PKCS12 \
  -srcstorepass "$PASSWORD" \
  -destkeystore "$KEYSTORE_PATH" \
  -deststoretype JKS \
  -deststorepass "$KEYSTORE_PASSWORD" \
  -alias "glassfish-cert" \
  -noprompt

if [ $? -ne 0 ]; then
    echo "Error: Falló la importación del certificado al keystore de GlassFish con keytool."
    echo "Esto puede ocurrir si el alias 'glassfish-cert' ya existe en $KEYSTORE_PATH y se usó -noprompt."
    echo "Considere borrar el alias existente o cambiar el nombre del alias."
    exit 1
fi
echo "Certificado importado correctamente al keystore de GlassFish con alias 'glassfish-cert'."


# 4. Configurar GlassFish usando asadmin para usar el certificado importado
echo "Configurando GlassFish y habilitando HTTPS para $HTTPS_LISTENER usando el certificado importado..."

# Usamos -W para pasar la contraseña del ADMIN de GlassFish al asadmin principal
PASSWORD_FILE=$(mktemp)
echo "$PASSWORD" > "$PASSWORD_FILE" # Asumo que la contraseña de GlassFish Admin es la misma que la del certificado PKCS12. CAMBIA si es diferente.
chmod 600 "$PASSWORD_FILE" # Asegurar que solo el propietario puede leerlo

$GLASSFISH_HOME/bin/asadmin --passwordfile "$PASSWORD_FILE" << EOF

# Habilitar SSL y configurar protocolos para el listener HTTPS
set configs.config.server-config.network-config.protocols.protocol.${HTTPS_LISTENER}.ssl.enabled=true
set configs.config.server-config.network-config.protocols.protocol.${HTTPS_LISTENER}.security-enabled=true
set configs.config.server-config.network-config.protocols.protocol.${HTTPS_LISTENER}.ssl.ssl3-enabled=false
set configs.config.server-config.network-config.protocols.protocol.${HTTPS_LISTENER}.ssl.tls-enabled=true

# Configurar el listener HTTPS para usar el certificado importado y los keystores/truststores
# Especificamos el alias del certificado que importamos con keytool
set configs.config.server-config.network-config.protocols.protocol.${HTTPS_LISTENER}.ssl.cert-nickname="glassfish-cert"

# Opcional pero recomendado: Asegurarse de que GlassFish usa los keystores/truststores por defecto
# GlassFish suele usar estos por defecto, pero establecerlos explícitamente es más seguro.
# Necesitarías la contraseña del keystore/truststore para esto en algunas versiones o comandos,
# pero para 'set' no suele ser necesario si ya está configurado en domain.xml.
# Si necesitas especificar la contraseña del keystore/truststore para asadmin,
# es más complejo en un heredoc. Los 'set' de nickname y rutas suelen funcionar sin ella
# si el keystore ya está enlazado en domain.xml.

# set configs.config.server-config.network-config.protocols.protocol.${HTTPS_LISTENER}.ssl.keystore="$KEYSTORE_PATH"
# set configs.config.server-config.network-config.protocols.protocol.${HTTPS_LISTENER}.ssl.truststore="$TRUSTSTORE_PATH"


# Opcional: Cambiar el puerto del listener HTTPS a 443 (Requiere permisos o proxy/port forwarding)
get configs.config.server-config.network-config.network-listeners.network-listener.${HTTPS_LISTENER}.port # Mostrar puerto actual
# set configs.config.server-config.network-config.network-listeners.network-listener.${HTTPS_LISTENER}.port=443 # Descomentar para cambiar a puerto 443

# Deshabilitar el listener HTTP por defecto para forzar HTTPS
echo "-> Deshabilitando ${HTTP_LISTENER} para forzar HTTPS..."
disable ${HTTP_LISTENER} || echo "Advertencia: Falló la deshabilitación de ${HTTP_LISTENER}. Podría no existir o estar ya deshabilitado."

# Reiniciar dominio para aplicar cambios
echo "-> Reiniciando dominio GlassFish..."
restart-domain --force # Forzar reinicio

exit
EOF

# Limpiar archivo de contraseña temporal
rm "$PASSWORD_FILE"

echo "--- Configuración SSL/HTTPS completada ---"
echo "Notas importantes:"
echo "1. Usas un certificado AUTO-FIRMADO. Los navegadores mostrarán ADVERTENCIAS DE SEGURIDAD."
echo "   Deberás añadir una excepción en cada navegador para acceder."
echo "2. El listener HTTP (${HTTP_LISTENER}) ha sido deshabilitado. Solo se podrá acceder por HTTPS."
echo "3. Asegúrate de que el puerto HTTPS de GlassFish (por defecto ${HTTPS_LISTENER} es 8181) está abierto"
echo "   en tu firewall (si lo tienes) y que tienes configurado el reenvío de puertos en tu router (443 -> 8181 de tu servidor) si accedes desde fuera."
echo "4. Para cambiar el puerto HTTPS a 443, edita el script y descomenta la línea correspondiente (puede requerir configuración adicional del sistema)."
echo "5. VERIFICA la contraseña de KEYSTORE_PASSWORD en el script ('changeit' por defecto) y ajustala si es necesario."
echo "6. Si el script falla en la importación con keytool, puede ser porque el alias 'glassfish-cert' ya existe."

# Puedes verificar el estado de los listeners con: asadmin list-network-listeners
# Puedes verificar la configuración de SSL con: asadmin get configs.config.server-config.network-config.protocols.protocol.${HTTPS_LISTENER}.ssl.*
# Puedes listar los certificados en el keystore con: keytool -list -v -keystore "$KEYSTORE_PATH" -storepass "$KEYSTORE_PASSWORD"

