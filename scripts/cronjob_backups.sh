#!/bin/bash
#Este cron agrega una linea al crontab para que ejecute el script de backups todos los dias a las 15:00 (1 PM) y escribe el log en un archivo

# Obtiene el directorio del script actual
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

#Linea a agregar al crontab
LINE="* 15 * * *   bash ${SCRIPT_DIR}/backup.sh >> ${SCRIPT_DIR}/cron.log"

#Comando a ejecutar
(crontab -u $(whoami) -l; echo "${LINE}" ) | crontab -u $(whoami) -
