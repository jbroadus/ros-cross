USER := $(shell stat -c "%u:%g" .)

ARCH ?= aarch64
IMAGE := ros-cross-builder-$(ARCH)

LOCAL_ROOT := ${PWD}/build
DOCKER_ROOT := /build

ROS_HOME := $(DOCKER_ROOT)/ros/$(ARCH)
ENV := -e ROS_ROOT=$(ROS_HOME)
ENV += -e ROS_HOME=$(ROS_HOME)
ENV += -e ROS_WORKSPACE=$(ROS_HOME)/ros_catkin_ws
DOCKER_CMD := docker run -v $(LOCAL_ROOT):$(DOCKER_ROOT) -w $(DOCKER_ROOT) $(ENV) -u $(USER) $(IMAGE)

.PHONY: build help
build help:
	$(DOCKER_CMD) make $@

.PHONY: distclean
distclean:
	rm -rf ros/$(ARCH)

.PHONY: docker
docker: docker/$(ARCH)/Dockerfile
	docker build -t $(IMAGE) docker/$(ARCH)
