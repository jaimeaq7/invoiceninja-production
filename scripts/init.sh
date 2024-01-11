#!/bin/bash
# Obtiene el directorio del script actual
script_dir="$(cd "$(dirname "$0")" && pwd)"

#Generamos key
./gen_key.sh

#Cambiamos permisos de directorio
./permisos.sh


#DOCKER
#Levantamos con docker-compose app version 5
docker-compose -f "${script_dir}/../docker-compose.yml" up -d

#CRONJOB
#Iniciamos script de cronjob_backup.sh para agregar linea en crontab para backups
#./cronjob_backup.sh

