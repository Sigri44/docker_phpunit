FROM php:7.3.12
#apt-get install libvpx-dev libjpeg-dev libxpm-dev zlib1g-dev libfreetype6-dev libexpat1-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev -yqq
RUN apt-get update -yqq && apt-get install -yqq \
  git \
  libzip-dev \
  libcurl4-gnutls-dev \
  libicu-dev \
  libmcrypt-dev \
  libxml2-dev \
  libpng-dev \
  libbz2-dev \
#  imap-dev \
#  openssl-dev \
  libc-client-dev \
  libkrb5-dev \
  && rm -r /var/lib/apt/lists/* \
  && docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos && docker-php-ext-install imap \
  && docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer
