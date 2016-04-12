#!/bin/bash
export DOCKER_MACHINE_NAME=${DOCKER_MACHINE_NAME}
export DOCKER_MACHINE_TMP_FILES=.tmp

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
