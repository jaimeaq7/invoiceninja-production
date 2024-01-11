#!/bin/bash
# Obtiene el directorio del script actual
script_dir="$(cd "$(dirname "$0")" && pwd)"


#Cambiar permisos de directorios para invoiceninja
chmod 755 ${script_dir}/../docker/app/public
sudo chown -R 1500:1500 ${script_dir}/../docker/app
