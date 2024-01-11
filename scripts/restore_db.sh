#!/bin/bash
# Obtiene el directorio del script actual
script_dir="$(cd "$(dirname "$0")" && pwd)"

# Construye la ruta completa al archivo .env
env_file="$script_dir/../.env"

# Verifica si el archivo .env existe antes de intentar cargarlo
if [ -f "$env_file" ]; then
    source "$env_file"
else
    echo "Error: El archivo .env no se encontró en $env_file"
fi


#Copiamos el backup al contenedor
docker cp ${BACKUP_PATH}/${BACKUP_NAME} ${DB_CONTAINER_NAME}:/
#Nos conectamos al contenedor y realizamos la restauracion
docker exec -t ${DB_CONTAINER_NAME} bash -c "mysql -u root --password=${MYSQL_ROOT_PASSWORD} < ${BACKUP_NAME}"
