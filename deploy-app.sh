#!/bin/bash
. ./config/docker-machine-settings.sh
. ./scripts/docker-machine-common.sh

./scripts/login-cloud-foundry.sh

if ! get-docker-machine-ip "${DOCKER_MACHINE_NAME}"; then
  echo "Error: could not get IP address from docker machine ${DOCKER_MACHINE_NAME}"; exit 1
fi

cf create-service-broker docker-broker containers secret http://${DOCKER_MACHINE_IP}

cf enable-service-access mongodb-easytravel

cf create-service mongodb-easytravel free mongodb-easytravel

cf push