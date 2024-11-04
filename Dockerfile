FROM php:8.3-fpm
RUN apt-get update \
    && apt-get install -y \
        libzip-dev \
        unzip \
        git \
        wget \
    && docker-php-ext-install -j$(nproc) bcmath sockets pdo_mysql \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.mode=debug,develop" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

WORKDIR /opt/project
