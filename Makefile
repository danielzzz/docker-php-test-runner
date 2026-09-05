PROJECT ?= danielzzzz/php-test-runner

# Defaults when no specific version is provided
VERSION ?= 8.2
NODE_MAJOR ?= 18

# PHP versions for the build-all target
VERSIONS = 7.4 8.1 8.2 8.3 8.4 8.5

docker: docker-build docker-push

docker-build:
	docker build . \
		-t ${PROJECT}:${VERSION} \
		--build-arg PHP_VERSION=${VERSION} \
		--build-arg NODE_MAJOR=${NODE_MAJOR}

docker-push:
	docker push ${PROJECT}:${VERSION}

# Build and push all versions
build-all:
	@for version in ${VERSIONS}; do \
		$(MAKE) docker-build VERSION=$$version; \
		$(MAKE) docker-push VERSION=$$version; \
	done
