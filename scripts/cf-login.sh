#!/bin/bash
. ./config/cf-settings.sh

echo -e "\n" | cf login -a "${CF_API_URL}" -u "${CF_USERNAME}" -p "${CF_PASSWORD}" --skip-ssl-validation
exit $?
