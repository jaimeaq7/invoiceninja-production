#Este comando crea un contenedor de docker temporal para generar una clave para poner en la variable APP_KEY
docker run --rm -it invoiceninja/invoiceninja php artisan key:generate --show