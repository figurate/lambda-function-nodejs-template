SHELL:=/bin/bash
REGISTRY?=figurate
IMAGE_NAME=lambda-function-python-template
TAGS?=latest
BUILD_ARGS?=
NODEJS_VERSION=12
AWS_DEFAULT_REGION?=ap-southeast-2

.PHONY: all build tag push

all: build

clean:
	rm -rf modules && \
		docker rmi $(REGISTRY)/$(IMAGE_NAME)

build:
	npm install && \
		docker build -t $(REGISTRY)/$(IMAGE_NAME) ${BUILD_ARGS} --build-arg NODEJS_VERSION=$(NODEJS_VERSION) \
 		--build-arg HTTP_PROXY=${http_proxy} --network=host .

tag:
	echo $(TAGS) | tr "/," "-\n" | xargs -n1 -I % docker tag $(REGISTRY)/$(IMAGE_NAME) $(REGISTRY)/$(IMAGE_NAME):%

push:
	echo $(TAGS) | tr "/," "-\n" | xargs -n1 -I % docker push $(REGISTRY)/$(IMAGE_NAME):%

run:
	docker run --rm -it -p 9000:8080 -e AWS_REGION=$(AWS_DEFAULT_REGION) $(REGISTRY)/$(IMAGE_NAME)
