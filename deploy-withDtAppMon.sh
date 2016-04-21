#!/bin/bash
. ./config/app-settings.sh
. ./config/cf-settings.sh
. ./config/dtAppMon-settings.sh

./scripts/cf-login.sh && \
cf create-service ${CF_ET_MONGODB_SERVICE} free ${CF_ET_MONGODB_SERVICE} && \
cf create-user-provided-service dynatrace-appmon -p "{ \"server\": \"${DT_APPMON_SERVER_URL}\" }" && \
cf push -f manifest-withDtAppMon.yml
exit $?