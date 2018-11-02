FROM php:7.1-apache

RUN apt-get -y update \
	&& apt-get install -y \
		libmcrypt-dev \
		libxslt-dev \
		zlib1g-dev \
		libpng-dev \
		libjpeg-dev \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install -j$(nproc) iconv

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install pdo_mysql mcrypt xsl intl zip bcmath -j$(nproc) gd soap

RUN a2enmod rewrite

EXPOSE 80
