ARG PHP_VERSION=8.2

FROM php:${PHP_VERSION}-cli

ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_MAJOR=18
ARG INSTALL_PHP_EXTENSIONS_VERSION=2.11.12

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/download/${INSTALL_PHP_EXTENSIONS_VERSION}/install-php-extensions /usr/local/bin/

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        gnupg \
        mariadb-client \
        wget \
    && install-php-extensions \
        @composer \
        ldap \
        opcache \
        zip \
        pdo_mysql \
        redis \
        exif \
        bcmath \
        gd \
        intl \
        xdebug \
        imagick \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
        | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" \
        > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && corepack enable \
    && corepack prepare yarn@stable --activate \
    && printf 'xdebug.mode=off\n' > /usr/local/etc/php/conf.d/zz-xdebug-defaults.ini \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY policy.xml /tmp/imagemagick-policy.xml
RUN if [ -d /etc/ImageMagick-6 ]; then \
        cp /tmp/imagemagick-policy.xml /etc/ImageMagick-6/policy.xml; \
    elif [ -d /etc/ImageMagick-7 ]; then \
        cp /tmp/imagemagick-policy.xml /etc/ImageMagick-7/policy.xml; \
    else \
        echo "ImageMagick policy directory not found" >&2; \
        exit 1; \
    fi \
    && rm /tmp/imagemagick-policy.xml
