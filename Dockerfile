FROM php:7.3.12

MAINTAINER Sigri44 <contact@sigri44.com>

ENV PHP_MEMORY_LIMIT -1

RUN apt-get update -yqq && apt-get install -yqq \
  git \
  libzip-dev \
  libcurl4-gnutls-dev \
  libicu-dev \
  libmcrypt-dev \
  libxml2-dev \
  libpng-dev \
  libbz2-dev \
  libc-client-dev \
  libkrb5-dev \
  && rm -r /var/lib/apt/lists/* \
  && docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos && docker-php-ext-install imap \
  && docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache \
  # Set environments
  && sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /usr/local/etc/php/php-fpm.conf
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer
