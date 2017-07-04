.phony: build run

current_dir := $(shell pwd)

DOCKER_CMD = $(shell which docker)

guard-%:
	@ if [ -z '${${*}}' ]; then echo 'Environment variable $* not set' && exit 1; fi

private_util: guard-NEXMO_KEY guard-NEXMO_SECRET
	${DOCKER_CMD} -D build \
		--build-arg key=${NEXMO_KEY} \
		--build-arg secret=${NEXMO_SECRET} \
		-t nexmo_private_util_${NEXMO_KEY}:latest \
		-f Dockerfile.private_util .

private_generate_jwt: guard-APPLICATION_ID guard-TYPE guard-NEXMO_KEY private_util
	${DOCKER_CMD} -D build \
		--build-arg key=${NEXMO_KEY} \
		--build-arg application_id=${APPLICATION_ID} \
		--build-arg type=${TYPE} \
		-t nexmo_private_jwt_${NEXMO_KEY}_${APPLICATION_ID}:latest \
		-f Dockerfile.generate.keyfile .
 
run: private_generate_jwt 
	$(DOCKER_CMD) run -t nexmo_private_jwt_${NEXMO_KEY}_${APPLICATION_ID}:latest 

explore_private_util: private_util
	$(DOCKER_CMD) run -ti -v $(current_dir):/host_drive nexmo_voice:latest /bin/bash

explore_generate_jwt: private_generate_jwt
	$(DOCKER_CMD) run -ti -v $(current_dir):/host_drive nexmo_private_jwt_${NEXMO_KEY}_${APPLICATION_ID}:latest /bin/bash

all: run
