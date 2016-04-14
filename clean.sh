#!/bin/bash
. ./config/cf-settings.sh

./scripts/cf-login.sh && \
cf delete-org "${CF_ORG}" -f && \
cf create-org "${CF_ORG}" && \
cf create-space "${CF_SPACE}" -o "${CF_ORG}" && \
./scripts/cf-login.sh
exit $?