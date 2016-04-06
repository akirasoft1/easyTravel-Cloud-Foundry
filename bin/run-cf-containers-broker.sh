#!/bin/bash
. ./bin/docker-machine-utils.sh

run-cf-containers-broker() {
  get-docker-machine-env ${DOCKER_MACHINE_NAME} || return $?

  docker run -d \
    --name cf-containers-broker \
    --publish 80:80 \
    --volume /var/run:/var/run \
    --volume /home/ubuntu/deploy/config/cf-containers-broker:/config \
    frodenas/cf-containers-broker
  return $?
}

if ! get-docker-machine-name ${DOCKER_MACHINE_NAME_FILE}; then
  echo "Error: could not retrieve docker machine name from file ${DOCKER_MACHINE_NAME_FILE}"; exit 1
fi

if ! run-cf-containers-broker; then
  echo "Error: could not run cf-containers-broker"; exit 1
fi