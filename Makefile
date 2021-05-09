REPO = cabanaonline/ubuntu
NAME = ubuntu
TAG = 14.04

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) \
		./

-include docker-helper-scripts/Makefile