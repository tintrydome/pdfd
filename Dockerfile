FROM php:8.2
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN docker-php-ext-install pdo mbstring
WORKDIR /app
COPY . /app
RUN composer install

RUN mv .env.example .env
RUN php artisan key:generate --ansi 
RUN php artisan migrate --force

CMD php artisan serve --host=0.0.0.0 --port=8181
EXPOSE 8181
