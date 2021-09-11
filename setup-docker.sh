cp .env.docker .env

# install dependencies
docker run --rm -v $(pwd):/app -w /app composer install --ignore-platform-reqs --no-autoloader --no-dev --no-interaction --no-progress --no-suggest --no-scripts --prefer-dist
docker run --rm -v $(pwd):/app -w /app composer dump-autoload --classmap-authoritative --no-dev --optimize
docker run --rm -v $(pwd):/app -w /app node npm install --production
docker run --rm -v $(pwd):/app -w /app node npm run prod

# Bootstrap application
docker-compose up -d --build

docker-compose exec app php artisan key:generate
docker-compose exec app php artisan migrate
docker-compose exec app php artisan migrate --seed
