#!/bin/bash
. ./bin/docker-machine-utils.sh

remove-docker-machine() {
  get-docker-machine-env ${DOCKER_MACHINE_NAME} || return $?

  docker-machine rm -f ${DOCKER_MACHINE_NAME}
  return $?
}

remove-temp-files() {
  rm -v -f ${DOCKER_MACHINE_NAME_FILE}
  rm -v -rf ./keys  
}

if ! get-docker-machine-name ${DOCKER_MACHINE_NAME_FILE}; then
  echo "Error: could not retrieve docker machine name from file ${DOCKER_MACHINE_NAME_FILE}"; exit 1
fi

if ! remove-docker-machine; then
  echo "Error: could not remove docker machine ${DOCKER_MACHINE_NAME}"; exit 1
fi

remove-temp-files