#!/bin/bash
. ./config/docker-machine-settings.sh
. ./scripts/docker-machine-common.sh

remove-docker-machine() {
  local NAME="$1"

  docker-machine rm -f "${NAME}"
  return $?
}

remove-temp-files() {
  local TMP_FILES="$1"

  rm -v -rf "${TMP_FILES}"
  return $?  
}

if ! remove-docker-machine "${DOCKER_MACHINE_NAME}"; then
  echo "Error: could not remove docker machine ${DOCKER_MACHINE_NAME}"; exit 1
fi

remove-temp-files "${DOCKER_MACHINE_TMP_FILES}"