# PHP Test Runner Docker Image

CLI image for running Laravel (and similar PHP) test suites. Includes PHP,
Composer, Node.js, Yarn, MariaDB client, Git, and common PHP extensions.

Published as `danielzzzz/php-test-runner`.

## Features

- PHP version via `PHP_VERSION` build arg (default `8.2`)
- Node.js major version via `NODE_MAJOR` build arg (default `18`)
- Composer, Yarn (via Corepack), MariaDB client, Git
- Extensions: ldap, opcache, zip, pdo_mysql, redis, exif, bcmath, gd, intl, imagick, xdebug
- Xdebug off by default (`xdebug.mode=off`); enable per run when needed
- ImageMagick policy with resource caps; PS/PDF/EPS/XPS enabled for PDF tests

## Using the image

```dockerfile
FROM danielzzzz/php-test-runner:8.2

COPY . .

RUN composer test
```

Coverage example:

```bash
docker run --rm -v "$PWD":/app -w /app \
  -e XDEBUG_MODE=coverage \
  danielzzzz/php-test-runner:8.2 \
  composer test
```

## Building

```bash
docker build -t danielzzzz/php-test-runner:8.2 \
  --build-arg PHP_VERSION=8.2 \
  --build-arg NODE_MAJOR=18 \
  .
```

Or with Make:

```bash
make docker-build VERSION=8.2 NODE_MAJOR=18
make docker-push VERSION=8.2   # requires docker login first
make build-all                 # 7.4, 8.1, 8.2, 8.3, 8.4, 8.5
```
