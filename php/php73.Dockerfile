FROM php:7.3-fpm

# Create non-root user
ARG USER
ARG UID
ARG TIME_ZONE
RUN useradd -m -U ${USER} -u ${UID} -p1 -s /bin/bash -G root -o \
## Edit PS1 in basrc
&& echo "PS1='${debian_chroot:+($debian_chroot)}\w\$ '" >> /home/${USER}/.bashrc \
&& echo "shopt -s autocd" >> /home/${USER}/.bashrc \
## Change www-data user to ${USER}
&& sed -i -e "s/www-data/${USER}/" /usr/local/etc/php-fpm.d/www.conf \
## Install necessary libraries for Magento2
## I add bash-completion for autocomplete "make" command
&& apt-get -y update \
    && apt-get -y install \
        libmcrypt-dev \
        libxslt-dev \
        zlib1g-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libzip-dev \
        bash-completion \
        git \
    && apt-get -y autoremove \
    && apt-get -y autoclean \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install pdo_mysql xsl intl zip bcmath -j$(nproc) gd soap gettext opcache exif sockets \
## Config opcache
&& echo "opcache.memory_consumption=128\n\
opcache.interned_strings_buffer=8\n\
opcache.max_accelerated_files=4000\n\
opcache.revalidate_freq=60\n\
opcache.fast_shutdown=1\n\
opcache.enable_cli=1\n\
opcache.blacklist_filename=/var/www/html/opcache.blacklist_filename.ini" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
## Install xdebug
&& pecl install xdebug \
&& docker-php-ext-enable xdebug \
&& echo "xdebug.remote_enable=on\n\
xdebug.remote_autostart=off\n\
xdebug.remote_host=10.5.0.1\n\
xdebug.remote_port=9000\n\
xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
&& sed -i 's/^/;/' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
&& echo "alias xdebug='php -d xdebug.remote_autostart=on'" >> /home/${USER}/.bashrc \
## Set memory_limit
&& echo "php_admin_value[memory_limit] = 512M" >> /usr/local/etc/php-fpm.d/www.conf \
&& echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/memory_limit.ini \
## Set execution timeout
&& echo "request_terminate_timeout = 0" >> /usr/local/etc/php-fpm.d/www.conf \
&& echo "max_execution_time = 0" >> /usr/local/etc/php/conf.d/max_execution_time.ini \
## Set timezone
&& echo "date.timezone = ${TIME_ZONE}" >> /usr/local/etc/php/conf.d/timezone.ini \
## Install composer
&& php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
&& php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer \
&& php -r "unlink('/tmp/composer-setup.php');" \
## Install custom scripts
&& mkdir -p /usr/local/bin \
&& chmod -R 666 /usr/local/etc/php/conf.d/*

COPY ./bin/* /usr/local/bin/

# Uncomment the following lines to use the extensions
RUN pecl install mailparse && docker-php-ext-enable mailparse \
    && docker-php-ext-install mysqli \
    && apt-get update && apt-get install -y libc-client-dev libkrb5-dev && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap

USER ${USER}
