#!/bin/bash
DOCKER_MACHINE_NAME=${DOCKER_MACHINE_NAME:-pcf-dev-docker-machine}
DOCKER_MACHINE_OWNER=${DOCKER_MACHINE_OWNER:-martin.etmajer@dynatrace.com}
DOCKER_MACHINE_CATEGORY=${DOCKER_MACHINE_CATEGORY:-dev}

AWS_REGION=${AWS_REGION:-us-east-1}
AWS_INSTANCE_TYPE=${AWS_INSTANCE_TYPE:-m3.medium}

. ./bin/docker-machine-utils.sh

create-ssh-keypair() { 
  local KEY_NAME="$1"
  local KEY_COMMENT="${KEY_NAME} Public Key"

  local PASSWORD_FILE_NAME="${KEY_NAME}.password"
  local PASSWORD=

  if [ -z "${KEY_NAME}" ]; then
    echo "Error: no name for creating SSH keypair provided"
    return 1
  fi

  mkdir -p keys
  ssh-keygen -q -t rsa -f keys/${KEY_NAME} -N "${PASSWORD}" -C "${KEY_COMMENT}"
  chmod 600 keys/${KEY_NAME}*

  if [ ! -z "${PASSWORD}" ]; then  
    echo ${PASSWORD} > keys/${PASSWORD_FILE_NAME}
  fi
}

create-docker-machine() {
  local MACHINE_NAME="$1"
  local MACHINE_OWNER="$2"
  local MACHINE_CATEGORY="$3"
  local AWS_REGION="$4"
  local AWS_INSTANCE_TYPE="$5"

  if ! create-docker-machine-name-file "${DOCKER_MACHINE_NAME}"; then
    echo "Error: could not create docker machine name file ${DOCKER_MACHINE_NAME_FILE}"; exit 1
  fi

  docker-machine create --driver amazonec2 \
    --amazonec2-tags Name,"${MACHINE_NAME}",Email,"${MACHINE_OWNER}",Category,${MACHINE_CATEGORY} \
    --amazonec2-region ${AWS_REGION} \
    --amazonec2-instance-type ${AWS_INSTANCE_TYPE} \
    --amazonec2-ssh-keypath "./keys/${MACHINE_NAME}" \
    ${MACHINE_NAME}
  return $?
}

deploy-docker-machine() {
  local MACHINE_NAME="$1"
  local DEPLOY_DB_CMD="
    mkdir -v /data && \
    cd /data && \
    tar xvzf ~/deploy/data/mongodb-database.tar.gz && \
    chown -vR ubuntu:ubuntu /data
  "

  docker-machine scp -r deploy ${MACHINE_NAME}:~ && \
  docker-machine ssh ${MACHINE_NAME} sudo -- sh -c "'${DEPLOY_DB_CMD}'"
  return $?
}

if ! create-ssh-keypair "${DOCKER_MACHINE_NAME}"; then
  echo "Error: could not create SSH key pair"; exit 1
fi

if ! create-docker-machine "${DOCKER_MACHINE_NAME}" "${DOCKER_MACHINE_OWNER}" "${DOCKER_MACHINE_CATEGORY}" "${AWS_REGION}" "${AWS_INSTANCE_TYPE}"; then
  echo "Error: could not create docker machine ${DOCKER_MACHINE_NAME}"; exit 1
fi

if ! deploy-docker-machine "${DOCKER_MACHINE_NAME}"; then
  echo "Error: could not deploy to docker machine ${DOCKER_MACHINE_NAME}"; exit 1
fi