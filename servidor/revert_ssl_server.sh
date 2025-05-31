#!/bin/bash
# Revertir configuración SSL de GlassFish
GLASSFISH_HOME="/opt/glassfish4"

$GLASSFISH_HOME/bin/asadmin << 'REVERT_EOF'
# 1. Deshabilitar SSL en el listener
set configs.config.server-config.network-config.protocols.protocol.http-listener-2.ssl.enabled=false
set configs.config.server-config.network-config.protocols.protocol.http-listener-2.security-enabled=false

# 2. Eliminar el certificado (opcional)
delete-ssl --certname glassfish-cert

# 3. Restaurar puerto por defecto (8181 si lo cambiaste)
set configs.config.server-config.network-config.network-listeners.network-listener.http-listener-2.port=8181

# 4. Reiniciar
restart-domain
exit
REVERT_EOF

echo "Configuración SSL revertida. GlassFish ahora usa HTTP sin cifrado."