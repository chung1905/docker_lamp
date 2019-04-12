FROM php:5.6-fpm

# Install necessary libraries for Magento2
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
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install pdo_mysql mcrypt xsl intl zip bcmath -j$(nproc) gd soap

# Install composer
RUN mkdir -p /usr/local/bin
COPY ./composer /usr/local/bin/

# Set memory_limit
RUN echo "php_admin_value[memory_limit] = 512M" >> /usr/local/etc/php-fpm.d/www.conf \
 && echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/memory_limit.ini

# Set execution timeout
RUN echo "request_terminate_timeout = 0" >> /usr/local/etc/php-fpm.d/www.conf \
 && echo "max_execution_time = 0" >> /usr/local/etc/php/conf.d/max_execution_time.ini

# Create non-root user
ARG USER_NAME
ARG UID
RUN useradd -m -U ${USER_NAME} -u ${UID} -p1 -s /bin/bash -G root -o

# Edit PS1 in basrc
RUN echo "PS1='${debian_chroot:+($debian_chroot)}\w\$ '" >> /home/${USER_NAME}/.bashrc

# Change www-data user to ${USER_NAME}
RUN sed -i -e "s/www-data/${USER_NAME}/" /usr/local/etc/php-fpm.d/www.conf