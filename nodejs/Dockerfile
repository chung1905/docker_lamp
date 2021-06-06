FROM node:lts-slim

# I add bash-completion for autocomplete "make" command
RUN apt-get -y update \
    && apt-get -y install \
        bzip2 \
        bash-completion \
        git \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

RUN npm install --global sass
WORKDIR /var/www/html
USER node
