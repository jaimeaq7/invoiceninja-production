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


#Nos conectamos al contenedor y realizamos el backup
docker exec -t ${DB_CONTAINER_NAME} bash -c "mysqldump -u root --password=${MYSQL_ROOT_PASSWORD} --databases ${DB_DATABASE} > ${DB_DATABASE}.sql"

#Copiamos el backup del contenedor a la maquina
docker cp ${DB_CONTAINER_NAME}:/${DB_DATABASE}.sql ${BACKUP_PATH}/${DB_DATABASE}$(date +%Y-%m-%d-%H.%M.%S).sql
#Borramos el backup del contenedor
docker exec -t ${DB_CONTAINER_NAME} bash -c "rm ${DB_DATABASE}.sql"

#Buscamos backups antiguos de  mas de 7 dias y los eliminamos
find  ${BACKUP_PATH} -type f -mtime +7 -name "ninja*" -delete

#Backup S3
#aws s3 --REGION ${REGION} sync --delete ${BACKUP_PATH} ${S3_BUCKET}
