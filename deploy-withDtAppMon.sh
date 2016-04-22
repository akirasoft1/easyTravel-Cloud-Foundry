#!/bin/bash
. ./config/app-settings.sh
. ./config/cf-settings.sh
. ./config/dtAppMon-settings.sh

./scripts/cf-target.sh && \
cf create-service "${CF_ET_MONGODB_SERVICE}" free "${CF_ET_MONGODB_SERVICE}" && \
cf create-user-provided-service "${CF_DT_APPMON_SERVICE}" -p "{ \"server\": \"${DT_APPMON_SERVER_IP}\" }" && \
cf push -f manifest-withDtAppMon.yml
exit $?