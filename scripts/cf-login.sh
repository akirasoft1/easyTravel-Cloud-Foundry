#!/bin/bash
. ./config/cf-settings.sh

./scripts/cf-api.sh && \
cf login -u "${CF_USERNAME}" -p "${CF_PASSWORD}" -o "${CF_ORG}" -s "${CF_SPACE}"
exit $?