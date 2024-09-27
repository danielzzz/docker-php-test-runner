PROJECT ?= danielzzzz/php-test-runner

# Define default version, in case no specific version is provided
VERSION ?= 8.2

# List of versions for the build-all target
VERSIONS = 7.4 8.1 8.2 8.3

docker: docker-build docker-push

docker-build:
	docker build . -t ${PROJECT}:${VERSION} --build-arg PHP_VERSION=${VERSION}

docker-push:
	docker login
	docker push ${PROJECT}:${VERSION}

# Build and push all versions
build-all:
	@for version in ${VERSIONS}; do \
		$(MAKE) docker-build VERSION=$$version; \
		$(MAKE) docker-push VERSION=$$version; \
	done