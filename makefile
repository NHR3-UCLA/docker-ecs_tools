# Usage:
# make build              # Builds Docker image
# make run                # Runs Docker container 
# make update_submodules  # Updates git submodules
# make build_dist_metrics # Build R library for distance metrics


.PHONY = all clean build_stan
.DEFAULT_GOAL := all

TAG=ecs-tools
PWD=$(shell pwd)

all: update_submodules build run

init_submodules:
	git submodule update --init --recursive

update_submodules: init_submodules
	git submodule foreach git pull origin main

build_dist_metrics: update_submodules
	cd distance_metrics && $(MAKE) build_R
	mv ./distance_metrics/progs/R_dist_metrics.so ./ecs_tools/Analyses/R_lib/.

build: build_dist_metrics
	docker build . -t $(TAG)

run: build
	docker run --rm -p 8888:8888 -v "$(PWD)":/home/jovyan/work $(TAG)

clean:
