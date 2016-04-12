#!/bin/bash
DOCKER_MACHINE_NAME=${DOCKER_MACHINE_NAME:-pcf-dev-docker-machine}
DOCKER_MACHINE_NAME_FILE=${DOCKER_MACHINE_NAME_FILE:-.docker-machine-aws}

DOCKER_MACHINE_AWS_OWNER=${DOCKER_MACHINE_AWS_OWNER}
DOCKER_MACHINE_AWS_CATEGORY=${DOCKER_MACHINE_AWS_CATEGORY}
DOCKER_MACHINE_AWS_REGION=${DOCKER_MACHINE_AWS_REGION:-us-east-1}
DOCKER_MACHINE_AWS_INSTANCE_TYPE=${DOCKER_MACHINE_AWS_INSTANCE_TYPE:-m3.medium}
DOCKER_MACHINE_AWS_FILES=.aws


create-docker-machine-name-file() {
  local NAME="$1"
  local NAME_FILE=${2:-"${DOCKER_MACHINE_AWS_FILES}/${DOCKER_MACHINE_NAME_FILE}"}

  echo ${NAME} > ${NAME_FILE}
  return $?
}

get-docker-machine-env() {
  local MACHINE_NAME="$1"

  if [ -z "${MACHINE_NAME}" ]; then
    if get-docker-machine-name; then
      MACHINE_NAME="${DOCKER_MACHINE_NAME}"
    fi
  fi

  if [ -z "${MACHINE_NAME}" ]; then
    echo "Error: docker machine name is undefined"
    return 1
  fi

  eval "$(docker-machine env ${MACHINE_NAME})"
  return $?
}