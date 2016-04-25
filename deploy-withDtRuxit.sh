#!/bin/bash
. ./config/app-settings.sh
. ./config/cf-settings.sh
. ./config/dtRuxit-settings.sh

./scripts/cf-target.sh && \
cf create-service "${CF_ET_MONGODB_SERVICE}" free "${CF_ET_MONGODB_SERVICE}" && \
cf create-user-provided-service "${CF_DT_RUXIT_SERVICE}" -p "{ \"server\": \"${DT_RUXIT_SERVER}\", \"tenant\": \"${DT_RUXIT_TENANT}\", \"tenanttoken\": \"${DT_RUXIT_TENANTTOKEN}\" }" && \
cf push -f manifest-withDtRuxit.yml
exit $?
