#!/bin/bash
./cf-clean.sh && \
./scripts/docker-machine-create-aws.sh && \
./scripts/docker-machine-deploy-cf-containers-broker.sh && \
./scripts/cf-deploy-service-brokers.sh
exit $?