#!/bin/bash
. ./config/cf-settings.sh

cf api "${CF_API_URL}" --skip-ssl-validation
exit $?