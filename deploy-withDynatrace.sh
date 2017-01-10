#!/bin/bash
. ./config/app-settings.sh
. ./config/cf-settings.sh
. ./config/dynatrace-settings.sh

./scripts/cf-target.sh && \
cf create-service "${CF_ET_MONGODB_SERVICE}" free "${CF_ET_MONGODB_SERVICE}" && \
cf create-user-provided-service "${CF_DT_SERVICE}" -p "{ \"environmentid\": \"${DT_ENVIRONMENTID}\", \"apitoken\": \"${DT_API_TOKEN}\", \"apiurl\": \"${DT_API_BASE_URL}\" }" && \
cf push -f manifest-withDynatrace.yml
exit $?
