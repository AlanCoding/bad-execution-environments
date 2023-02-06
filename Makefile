
# most common customization would be to change this base image
# depending on your task, you may prefer to use awx-ee instead
# if you have no need for partially correct behavior, you may prefer a lower-level base
BASE_IMAGE ?= quay.io/ansible/ansible-runner:latest

# this allows switching from docker to podman, and is taken from ansible-runner
CONTAINER_ENGINE ?= docker

.PHONY: build push clean

build:
	cd starting_line/ && $(CONTAINER_ENGINE) build --build-arg BASE_IMAGE=$(BASE_IMAGE) -t ghcr.io/alancoding/bad-ee:starting_line .

push:
	$(CONTAINER_ENGINE) push ghcr.io/alancoding/bad-ee:starting_line

clean:
	$(CONTAINER_ENGINE) rmi -f ghcr.io/alancoding/bad-ee:starting_line
