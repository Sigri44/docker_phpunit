FROM php:7.3.12-alpine

RUN apk upgrade --update && apk add \
     git \
     libzip-dev \
     libcurl4-gnutls-dev \
     libicu-dev \
     libmcrypt-dev \
     libxml2-dev \
     libpng-dev \
     libbz2-dev \
     imap-dev \
     openssl-dev \
  && docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache \
  && docker-php-ext-configure imap --with-imap --with-imap-ssl \
  && docker-php-ext-install imap

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && rm -rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer
