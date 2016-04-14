#!/bin/bash
. ./config/app-settings.sh
. ./config/cf-settings.sh

./scripts/cf-login.sh && \
cf create-service ${CF_ET_MONGODB_SERVICE} free ${CF_ET_MONGODB_SERVICE} && \
#cf push
exit $?
