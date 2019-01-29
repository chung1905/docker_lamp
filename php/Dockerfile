FROM php:7.1-fpm-alpine

# Install necessary libraries for Magento2
RUN apk add --no-cache \
    libmcrypt-dev \
    libxslt-dev \
    libpng-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    icu-dev \
    gettext \
    $PHPIZE_DEPS
RUN docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && \
        NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)
RUN docker-php-ext-install -j$(nproc) iconv
RUN docker-php-ext-install pdo_mysql mcrypt xsl intl zip bcmath -j$(nproc) gd soap

# Install xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo $'xdebug.remote_enable=on\n\
xdebug.remote_autostart=off\n\
xdebug.remote_host=10.5.0.1\n\
xdebug.remote_port=9000\n\
xdebug.remote_handler=dbgp' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Install cron
#RUN apt-get install -y cron

# Create non-root user
ARG USER_NAME
ARG UID
RUN adduser -D ${USER_NAME} -u ${UID}

# Change www-data user to ${USER_NAME}
RUN sed -i -e "s/www-data/${USER_NAME}/" /usr/local/etc/php-fpm.d/www.conf
