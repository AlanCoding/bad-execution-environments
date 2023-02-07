# most common customization would be to change this base image
# depending on your task, you may prefer to use awx-ee instead
# if you have no need for partially correct behavior, you may prefer a lower-level base
BASE ?= quay.io/ansible/ansible-runner:latest

# the name of the output image without the tag
OUTPUT ?= ghcr.io/alancoding/bad-ee

# Container engine - this allows switching from docker to podman, and is taken from ansible-runner
ENGINE ?= docker

# the scenarios in this repo, all should be a folder here
SCENARIOS = starting_line ending_line traceback artifacts

.PHONY: build push clean

show:
	$(foreach scenario,$(SCENARIOS),echo $(OUTPUT):$(scenario);)

build:
	$(foreach scenario,$(SCENARIOS),$(ENGINE) build --build-arg BASE_IMAGE=$(BASE) -t $(OUTPUT):$(scenario) $(scenario)/;)

push:
	$(foreach scenario,$(SCENARIOS),$(ENGINE) push $(OUTPUT):$(scenario);)

clean:
	$(foreach scenario,$(SCENARIOS),$(ENGINE) rmi -f $(OUTPUT):$(scenario);)
