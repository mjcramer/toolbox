
DOCKER_REPOSITORY := mjcramer/toolbox
DOCKER_TAG := $(shell git describe --tags)

#
# Pre-checks
#

# make sure docker is installed
DOCKER_EXISTS := @echo "Found docker..."
DOCKER_WHICH := $(shell which docker)
ifeq ($(strip $(DOCKER_WHICH)),)
	DOCKER_EXISTS := @echo "\nERROR: docker not found.\nSee: https://docs.docker.com/" && exit 1
endif

#
# Targets
#
default: up

.PHONY: check build tag push shutdown debug shell clean

check:
	$(DOCKER_EXISTS)

build: check
	@echo "Building docker image $(DOCKER_REPOSITORY):$(DOCKER_TAG)..."
	@docker build --tag $(DOCKER_REPOSITORY):$(DOCKER_TAG) .

run:
	@docker run --rm --interactive --tty --entrypoint bash $(DOCKER_REPOSITORY):$(DOCKER_TAG)

tag:
ifdef (DOCKER_REGISTRY)
	@docker tag $(DOCKER_IMAGE):$(DOCKER_TAG) $(DOCKER_REGISTRY)/$(DOCKER_REPOSITORY):$(DOCKER_TAG)
else
	@docker tag $(DOCKER_IMAGE):$(DOCKER_TAG) $(DOCKER_REPOSITORY):$(DOCKER_TAG)
endif

push: tag
ifdef (DOCKER_REGISTRY)
	docker push $(DOCKER_REGISTRY)/$(DOCKER_REPOSITORY):$(DOCKER_TAG)
else
	docker push $(DOCKER_REPOSITORY):$(DOCKER_TAG)
endif

debug:
	docker run -it --rm --name $(DOCKER_INSTANCE) -v $(shell pwd)$(APP_DIR):$(APP_PATH) --net=host -e ENVDEVDB=$(ENVDEVDB) $(DOCKER_IMAGE)

shell:
	docker exec -it $(DOCKER_INSTANCE) /bin/bash

clean:
	docker rm $(shell docker ps -a -q)

