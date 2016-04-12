#!/bin/bash
export ET_SRC_URL="http://172.16.98.141/dynatrace/easyTravel-2.0.0.2227-src.zip"

cd ./app
for app in `ls -d */`; do
  cd ${app}
  ./build-in-docker.sh
  cd ..
done