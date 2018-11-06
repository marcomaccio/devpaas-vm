#!/usr/bin/env bash
export WEBSTORM_VERSION="2018.2.3"

echo "Download WebStorm version ${WEBSTORM_VERSION} ..."

wget https://download.jetbrains.com/webstorm/WebStorm-${WEBSTORM_VERSION}.targ.gz

tar xfz WebStorm-${WEBSTORM_VERSION}.tar.gz

