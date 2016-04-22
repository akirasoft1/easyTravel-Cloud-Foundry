#!/bin/bash
. ./config/cf-settings.sh

./scripts/docker-machine-create-aws.sh && \
./scripts/docker-machine-deploy-cf-containers-broker.sh && \
./scripts/cf-login.sh && \
cf create-org "${CF_ORG}" && \
cf create-space "${CF_SPACE}" -o "${CF_ORG}" && \
./scripts/cf-deploy-service-brokers.sh
exit $?