#!/bin/bash
. ./config/cf-settings.sh

./scripts/cf-login.sh && \
cf target -o "${CF_ORG}" -s "${CF_SPACE}"
exit $?