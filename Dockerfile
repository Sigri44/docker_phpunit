FROM php:7.3.12-alpine

MAINTAINER Sigri44 <contact@sigri44.com>

ENV PHP_MEMORY_LIMIT -1

RUN apk upgrade --update && apk add \
    autoconf file g++ gcc binutils isl libatomic libc-dev musl-dev make re2c libstdc++ libgcc mpc1 mpfr3 gmp libgomp icu-dev \
    git \
    libzip-dev \
    libmcrypt-dev \
    libxml2-dev \
    libpng-dev \
    bzip2-dev \
    imap-dev \
    openssl-dev \
    openssh-client \
    && docker-php-ext-install mbstring pdo_mysql json intl gd xml zip bz2 opcache \
    && docker-php-ext-configure imap --with-imap --with-imap-ssl \
    && docker-php-ext-install imap

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    # Set environments
    && sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /usr/local/etc/php/php.ini

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && rm -rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
