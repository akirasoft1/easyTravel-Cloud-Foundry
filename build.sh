#!/bin/bash
. ./config/app-settings.sh

cd ./app
for app in `ls -d */`; do
  cd "${app}"
  ./build-in-docker.sh
  cd ..
done