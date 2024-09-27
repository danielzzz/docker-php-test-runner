ARG PHP_VERSION=8.2

FROM php:${PHP_VERSION}-cli
ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_VERSION=18.x

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN apt update &&  apt install -y mariadb-client git wget 

RUN install-php-extensions ldap \
    opcache \
    zip \
    pdo_mysql \
    redis \
    exif \
    bcmath \
    gd \
    intl \
    xdebug \
    imagick

# node and yarn
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash
RUN apt install -y nodejs
RUN npm install -g yarn -v
RUN apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY policy.xml /etc/ImageMagick-6/policy.xml
