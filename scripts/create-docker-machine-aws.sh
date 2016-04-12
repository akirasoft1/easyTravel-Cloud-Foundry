#!/bin/bash
. ./config/docker-machine-settings.sh
. ./scripts/docker-machine-aws-common.sh

create-ssh-keypair() { 
  local KEY_NAME="$1"
  local KEY_COMMENT="${KEY_NAME} Public Key"

  local PASSWORD_FILE_NAME="${KEY_NAME}.password"
  local PASSWORD=

  if [ -z "${KEY_NAME}" ]; then
    echo "Error: no name for creating SSH keypair provided"
    return 1
  fi

  mkdir -p ${DOCKER_MACHINE_AWS_FILES}/keys
  ssh-keygen -q -t rsa -f ${DOCKER_MACHINE_AWS_FILES}/keys/${KEY_NAME} -N "${PASSWORD}" -C "${KEY_COMMENT}"
  chmod 600 ${DOCKER_MACHINE_AWS_FILES}/keys/${KEY_NAME}*

  if [ ! -z "${PASSWORD}" ]; then  
    echo ${PASSWORD} > ${DOCKER_MACHINE_AWS_FILES}/keys/${PASSWORD_FILE_NAME}
  fi
}

create-docker-machine() {
  local MACHINE_NAME="$1"
  local AWS_NODE_OWNER="$2"
  local AWS_NODE_CATEGORY="$3"
  local AWS_REGION="$4"
  local AWS_INSTANCE_TYPE="$5"

  if ! create-docker-machine-name-file "${DOCKER_MACHINE_NAME}"; then
    echo "Error: could not create docker machine name file ${DOCKER_MACHINE_NAME_FILE}"; exit 1
  fi

  docker-machine create --driver amazonec2 \
    --amazonec2-tags Name,"${MACHINE_NAME}",Email,"${AWS_NODE_OWNER}",Category,${AWS_NODE_CATEGORY} \
    --amazonec2-region ${DOCKER_MACHINE_AWS_REGION} \
    --amazonec2-instance-type ${DOCKER_MACHINE_AWS_INSTANCE_TYPE} \
    --amazonec2-ssh-keypath "${DOCKER_MACHINE_AWS_FILES}/keys/${MACHINE_NAME}" \
    ${MACHINE_NAME}
  return $?
}

if ! create-ssh-keypair "${DOCKER_MACHINE_NAME}"; then
  echo "Error: could not create SSH key pair"; exit 1
fi

if ! create-docker-machine "${DOCKER_MACHINE_NAME}" "${DOCKER_MACHINE_AWS_OWNER}" "${DOCKER_MACHINE_AWS_CATEGORY}" "${DOCKER_MACHINE_AWS_REGION}" "${DOCKER_MACHINE_AWS_INSTANCE_TYPE}"; then
  echo "Error: could not create docker machine ${DOCKER_MACHINE_NAME}"; exit 1
fi
