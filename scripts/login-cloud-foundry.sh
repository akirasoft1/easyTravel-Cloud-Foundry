#!/bin/bash
. ./config/cloud-foundry-settings.sh

cf api ${CF_API_URL} --skip-ssl-validation 
cf login -u ${CF_USERNAME} -p ${CF_PASSWORD}
