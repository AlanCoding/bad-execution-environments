# most common customization would be to change this base image
# depending on your task, you may prefer to use awx-ee instead
# if you have no need for partially correct behavior, you may prefer a lower-level base
BASE ?= quay.io/ansible/ansible-runner:latest

# the name of the output image without the tag
OUTPUT ?= ghcr.io/alancoding/bad-ee

# Container engine - this allows switching from docker to podman, and is taken from ansible-runner
ENGINE ?= docker

# the scenarios in this repo, all should be a folder here
SCENARIOS ?= starting_line ending_line traceback artifacts

# location where ansible-runner is installed
FOLDER ?= /usr/local/lib/python3.8/site-packages/ansible_runner

.PHONY: show build test push clean

# Print the image names for each scenario
show:
	@$(foreach scenario,$(SCENARIOS),echo $(OUTPUT):$(scenario);)

build:
	$(foreach scenario,$(SCENARIOS),$(ENGINE) build --build-arg BASE_IMAGE=$(BASE) --build-arg FOLDER=$(FOLDER) -t $(OUTPUT):$(scenario) $(scenario)/;)

# Run and show the worker output for each scenario, which should show the bad syntax injected into the image
run:
	ansible-runner transmit _demo/ -p test.yml > transmit_data.txt
	$(foreach scenario,$(SCENARIOS),echo -e "\n$(scenario):" && $(ENGINE) run --rm -v $(shell pwd):/runner:Z $(OUTPUT):$(scenario) /bin/bash -c "cat transmit_data.txt | ansible-runner worker";)

# Run and process the output from each scenario, will give messy results because of the errors
test:
	ansible-runner transmit _demo/ -p test.yml > transmit_data.txt
	rm -rf _outs/
	mkdir _outs/
	@$(foreach scenario,$(SCENARIOS),$(ENGINE) run --rm -v $(shell pwd):/runner:Z $(OUTPUT):$(scenario) /bin/bash -c "cat transmit_data.txt | ansible-runner worker > _outs/$(scenario).txt";)
	$(foreach scenario,$(SCENARIOS),echo -e "\n$(scenario):" && cat _outs/$(scenario).txt | ansible-runner process _outs/$(scenario);)

push:
	$(foreach scenario,$(SCENARIOS),$(ENGINE) push $(OUTPUT):$(scenario);)

clean:
	$(foreach scenario,$(SCENARIOS),$(ENGINE) rmi -f $(OUTPUT):$(scenario);)
