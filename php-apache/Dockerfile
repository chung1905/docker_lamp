FROM php:7.1-apache

RUN apt-get -y update \
    && apt-get install -y \
        libmcrypt-dev \
        libxslt-dev \
        zlib1g-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev

RUN docker-php-ext-install -j$(nproc) iconv
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install pdo_mysql mcrypt xsl intl zip bcmath -j$(nproc) gd soap
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN apt-get install -y cron

COPY ./php/conf.d/xdebug/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/

RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod headers

ARG USER_NAME
ARG UID

RUN useradd -m -U ${USER_NAME} -u ${UID} -p1 -s /bin/bash -G root -o
COPY ./bash/.bashrc /home/${USER_NAME}

ENV APACHE_RUN_USER ${USER_NAME}
ENV APACHE_RUN_GROUP ${USER_NAME}

ENV SSL_CERT_DIR /etc/ssl/certs/apache2
ENV SSL_PRIV_DIR /etc/ssl/private/apache2

RUN rm -rf /var/lib/apt/lists/*
