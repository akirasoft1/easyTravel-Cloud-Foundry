#!/bin/bash
. ./config/cf-settings.sh

./scripts/cf-target.sh && \
cf delete easytravel-backend -f && \
cf delete easytravel-frontend -f && \
cf delete-service "${CF_ET_MONGODB_SERVICE}" -f &&
cf delete-service "${CF_DT_APPMON_SERVICE}" -f
exit $?