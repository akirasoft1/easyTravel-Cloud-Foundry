#!/bin/bash
. ./config/cf-settings.sh

./clean.sh && \
./scripts/cf-login.sh && \
cf delete-service-broker "${CF_DOCKER_SERVICE_BROKER_NAME}" -f && \
./scripts/docker-machine-delete-aws.sh
exit $?