#!/bin/bash
. ./config/docker-machine-settings.sh
. ./scripts/docker-machine-aws-common.sh

remove-docker-machine() {
  get-docker-machine-env ${DOCKER_MACHINE_NAME} || return $?

  docker-machine rm -f ${DOCKER_MACHINE_NAME}
  return $?
}

remove-temp-files() {
  rm -v -rf ${DOCKER_MACHINE_AWS_FILES}  
}

if ! remove-docker-machine; then
  echo "Error: could not remove docker machine ${DOCKER_MACHINE_NAME}"; exit 1
fi

remove-temp-files