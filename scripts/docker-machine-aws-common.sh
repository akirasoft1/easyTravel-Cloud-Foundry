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
  local PATH="$2"

  echo ${NAME} > "${PATH}"
  return $?
}

get-docker-machine-env() {
  local NAME="$1"

  eval "$(docker-machine env ${NAME})"
  return $?
}

get-docker-machine-ip() {
  local NAME="$1"

  DOCKER_MACHINE_IP=$(docker-machine ip ${NAME})
  return $?
}

get-docker-machine-host() {
  local NAME="$1"

  get-docker-machine-ip "${NAME}" || return $?

  DOCKER_MACHINE_HOST=$(nslookup ${DOCKER_MACHINE_IP} | sed -n 's/.*arpa.*name = \(.*\)\./\1/p')
  return $?
}
