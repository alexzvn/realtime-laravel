FROM nginx:alpine

ENV APP_PORT=80

COPY . /var/www/html
COPY .docker/nginx/conf.d/ /etc/nginx/conf.d/

