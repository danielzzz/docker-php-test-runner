# PHP Test Runner Docker Image

This repository provides a Docker image for running Laravel applications with support for PHP, Node.js, and various extensions. It also includes Goss for validating the image.

## Features

- PHP (dynamic versioning)
- Node.js (dynamic versioning)
- MariaDB Client
- Git
- Various PHP extensions installed

## Using the image
In your Dockerfile
```
FROM danielzzzz/php-test-runner:8.2

COPY . .

RUN php composer.phar test

```

## Getting Started

### Prerequisites

- Docker installed on your machine
- Make (optional for using the Makefile)

### Building the Docker Image

You can build the Docker image using the following command:

```bash
docker build -t my-laravel-image --build-arg PHP_VERSION=8.2 --build-arg NODE_VERSION=18.x .