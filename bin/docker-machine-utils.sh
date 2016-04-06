#!/bin/bash
DOCKER_MACHINE_NAME_FILE=.docker-machine-aws

create-docker-machine-name-file() {
  local NAME="$1"
  local NAME_FILE=${2:-${DOCKER_MACHINE_NAME_FILE}}

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

get-docker-machine-name() {
  local NAME_FILE=${1:-${DOCKER_MACHINE_NAME_FILE}}

  if [ ! -f ${NAME_FILE} ]; then
    echo "Error: file ${NAME_FILE} does not exist"
    return 1
  fi

  DOCKER_MACHINE_NAME=`cat ${NAME_FILE}`
}