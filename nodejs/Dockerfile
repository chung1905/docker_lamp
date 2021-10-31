FROM node:lts-slim

# I add bash-completion for autocomplete "make" command
RUN apt-get -y update \
    && apt-get -y install \
        bzip2 \
        bash-completion \
        git \
        make \
	curl \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

RUN npm install --global sass
WORKDIR /var/www/html
USER node
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
