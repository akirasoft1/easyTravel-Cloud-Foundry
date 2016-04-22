#!/bin/bash
. ./config/cf-settings.sh

./clean.sh && \
./scripts/cf-target.sh && \
cf delete-space "${CF_SPACE}" -f && \
cf delete-org "${CF_ORG}" -f && \
cf delete-service-broker "${CF_DOCKER_SERVICE_BROKER_NAME}" -f && \
./scripts/docker-machine-delete-aws.sh
exit $?