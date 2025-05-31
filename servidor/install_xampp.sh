#!/bin/bash

# Este script debe ejecutarse con privilegios de root
# Script para instalar xampp 8.2.12 en ubuntu 24.04

if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como root o con sudo."
  exit 1
fi
# Descargar el instalador de XAMPP si no existe el fichero xampp-linux-x64-8.2.12-0-installer.run
# en el directorio actual
if [ ! -f xampp-linux-x64-8.2.12-0-installer.run ]; then
  echo "Descargando el instalador de XAMPP..."
  wget https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.2.12/xampp-linux-x64-8.2.12-0-installer.run -O xampp-linux-x64-8.2.12-0-installer.run
else
  echo "El instalador de XAMPP ya existe."
fi

# dar permisos de ejecución al instalador
chmod 755 xampp-linux-*-installer.run
# Ejecutar el instalador de XAMPP
./xampp-linux-x64-8.2.12-0-installer.run

