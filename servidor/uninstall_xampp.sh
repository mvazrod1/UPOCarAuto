#!/bin/bash

# Este script debe ejecutarse con privilegios de root
# Script para desinstalar xampp 8.2.12 en ubuntu 24.04

if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como root o con sudo."
  exit 1
fi
# Verificar si XAMPP está instalado
if [ ! -d "/opt/lampp" ]; then
  echo "XAMPP no está instalado en el sistema."
  exit 1
fi
# Detener XAMPP si está en ejecución
/opt/lampp/lampp stop
# Desinstalar XAMPP
echo "Desinstalando XAMPP..."
rm -rf /opt/lampp
echo "XAMPP ha sido desinstalado correctamente."
