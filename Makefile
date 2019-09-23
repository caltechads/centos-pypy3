PYPY_VERSION = 3.6-v7.1.1
BUILD = 1
VERSION = $(PYPY_VERSION)-build$(BUILD)

PACKAGE = pypy36

#======================================================================

version:
	@echo ${VERSION}

image_name:
	@echo ${DOCKER_REGISTRY}/${PACKAGE}:${VERSION}

force-build:
	docker build --no-cache -t earthworm:${VERSION} .
	docker tag ${PACKAGE}:${VERSION} earthworm:latest
	docker tag ${PACKAGE}:${VERSION} earthworm:${PYPY_VERSION}
	docker image prune -f

build:
	docker build -t ${PACKAGE}:${VERSION} .
	docker tag ${PACKAGE}:${VERSION} ${PACKAGE}:latest
	docker tag ${PACKAGE}:${VERSION} ${PACKAGE}:${PYPY_VERSION}
	docker image prune -f

dev:
	docker-compose up

docker-clean:
	docker stop $(shell docker ps -a -q)
	docker rm $(shell docker ps -a -q)

exec:
	docker exec -ti pypy36 bash