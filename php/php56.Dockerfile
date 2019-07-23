FROM php:5.6-fpm

# Create non-root user
ARG USER_NAME
ARG UID
RUN useradd -m -U ${USER_NAME} -u ${UID} -p1 -s /bin/bash -G root -o \
# Edit PS1 in basrc
&& echo "PS1='${debian_chroot:+($debian_chroot)}\w\$ '" >> /home/${USER_NAME}/.bashrc \
# Change www-data user to ${USER_NAME}
&& sed -i -e "s/www-data/${USER_NAME}/" /usr/local/etc/php-fpm.d/www.conf \
# Install necessary libraries for Magento2
&& apt-get -y update \
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
    && docker-php-ext-install pdo_mysql mcrypt xsl intl zip bcmath -j$(nproc) gd soap gettext opcache mysqli \
# Config opcache
&& echo "opcache.memory_consumption=128\n\
opcache.interned_strings_buffer=8\n\
opcache.max_accelerated_files=4000\n\
opcache.revalidate_freq=60\n\
opcache.fast_shutdown=1\n\
opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
# Set always_populate_raw_post_data
&& echo "always_populate_raw_post_data = -1" >> /usr/local/etc/php/conf.d/aprpd.ini \
# Set memory_limit
&& echo "php_admin_value[memory_limit] = 512M" >> /usr/local/etc/php-fpm.d/www.conf \
&& echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/memory_limit.ini \
# Set execution timeout
&& echo "request_terminate_timeout = 0" >> /usr/local/etc/php-fpm.d/www.conf \
&& echo "max_execution_time = 0" >> /usr/local/etc/php/conf.d/max_execution_time.ini \
# Install composer
&& mkdir -p /usr/local/bin
COPY ./bin/ /usr/local/bin/
USER ${USER_NAME}
