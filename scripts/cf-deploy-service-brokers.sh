#!/bin/bash
. ./config/cf-settings.sh
. ./config/docker-machine-settings.sh
. ./scripts/docker-machine-common.sh

./scripts/cf-target.sh

create-docker-service-broker() {
  local SERVICE_BROKER="$1"
  local USERNAME="$2"
  local PASSWORD="$3"
  local URL="$4"

  ./scripts/wait-for-cmd.sh "cf create-service-broker '${SERVICE_BROKER}' '${USERNAME}' '${PASSWORD}' '${URL}'" 60
  return $?
}

enable-service-access() {
  local SERVICE="$1"
  local ORG="$2"

  cf enable-service-access "${SERVICE}"
  return $?
}

if ! get-docker-machine-ip "${DOCKER_MACHINE_NAME}"; then
  echo "Error: could not get IP address from docker machine ${DOCKER_MACHINE_NAME}"; exit 1
fi

if ! create-docker-service-broker "${CF_DOCKER_SERVICE_BROKER_NAME}" "${CF_DOCKER_SERVICE_USERNAME}" "${CF_DOCKER_SERVICE_PASSWORD}" "http://${DOCKER_MACHINE_IP}"; then
  echo "Error: could not create docker service broker ${CF_DOCKER_SERVICE_BROKER_NAME}"; exit 1
fi

if ! enable-service-access "${CF_ET_MONGODB_SERVICE}" "${CF_ORG}"; then
  echo "Error: could not enable access to service ${CF_ET_MONGODB_SERVICE}"; exit 1
fi