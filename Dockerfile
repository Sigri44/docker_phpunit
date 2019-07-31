FROM php:latest
#apt-get install git libzip-dev libcurl4-gnutls-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev -yqq
RUN apt-get update -yqq && apt-get install -y \
  git \
  libzip-dev \
  libcurl4-gnutls-dev \
  libicu-dev \
  libmcrypt-dev \
  libxml2-dev \
  libpng-dev \
  libbz2-dev -yqq
RUN docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug