#!/bin/bash
APP_PREFIX=app

cd ${APP_PREFIX}
for app in `ls -d */`; do
  cd ${app}
  ./build-in-docker.sh
  cd ..
done