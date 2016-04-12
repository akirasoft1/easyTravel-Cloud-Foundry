#!/bin/bash
. ./config/docker-machine-settings.sh
. ./scripts/docker-machine-aws-common.sh

DOCKER_MACHINE_DEPLOY_HOME="~/deploy"

create-deploy-home-dir() {
  get-docker-machine-env ${DOCKER_MACHINE_NAME} || return $?
  docker-machine ssh ${DOCKER_MACHINE_NAME} mkdir -pv ${DOCKER_MACHINE_DEPLOY_HOME}
  return $?
}

deploy-cf-containers-broker-config() {
  local EXTERNAL_IP=$(docker-machine ip ${DOCKER_MACHINE_NAME})
  local EXTERNAL_HOST=$(nslookup ${EXTERNAL_IP} | sed -n 's/.*arpa.*name = \(.*\)\./\1/p')

  sed -i '' -E "s/(external_ip:).*/\1 ${EXTERNAL_IP}/" deploy/config/cf-containers-broker/settings.yml
  sed -i '' -E "s/(external_host:).*/\1 ${EXTERNAL_HOST}/" deploy/config/cf-containers-broker/settings.yml

  get-docker-machine-env ${DOCKER_MACHINE_NAME} || return $?
  docker-machine scp -r deploy/config ${DOCKER_MACHINE_NAME}:${DOCKER_MACHINE_DEPLOY_HOME}
  return $?
}

deploy-mongodb-easytravel-db() {
  local ET_DB_HOME=/easyTravel-data

  local DEPLOY_CMD="
    mkdir -pv ${ET_DB_HOME} && \
    cd ${ET_DB_HOME} && \
    tar xvzf ~/deploy/data/easyTravel-mongodb-db.tar.gz && \
    chown -vR ubuntu:ubuntu ${ET_DB_HOME}
  "

  get-docker-machine-env ${DOCKER_MACHINE_NAME} || return $?
  docker-machine scp -r app/easyTravel/deploy/data ${DOCKER_MACHINE_NAME}:${DOCKER_MACHINE_DEPLOY_HOME} && \
  docker-machine ssh ${DOCKER_MACHINE_NAME} sudo -- sh -c "'${DEPLOY_CMD}'"
  return $?
}

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

if ! create-deploy-home-dir; then
  echo "Error: could not create deployment home directory ${DOCKER_MACHINE_DEPLOY_HOME}"; exit 1
fi

if ! deploy-cf-containers-broker-config; then
  echo "Error: could not deploy cf-containers-broker configuration"; exit 1
fi

if ! deploy-mongodb-easytravel-db; then
  echo "Error: could not deploy MongoDB easyTravel database"; exit 1
fi

if ! run-cf-containers-broker; then
  echo "Error: could not run cf-containers-broker"; exit 1
fi
