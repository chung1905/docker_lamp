FROM node:lts-slim

# Install necessary libraries for Magento2
# I add bash-completion for autocomplete "make" command
RUN apt-get -y update \
    && apt-get -y install \
        bzip2 \
        bash-completion \
        git \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html
USER node
