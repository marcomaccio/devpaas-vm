#!/bin/bash
set -e

#UPDATES_URL="http://updates.jenkins-ci.org/download/plugins/$plugin/$version"
UPDATES_URL="https://updates.jenkins-ci.org/latest"

if [ $# -ne 1 ]; then
  echo "USAGE: $0 plugin-list-file"
  exit 1
fi

#service jenkins stop > /dev/null 2>&1

plugin_list=$1
readonly PLUGINS=`cat $plugin_list`

plugin_dir=/var/lib/jenkins/plugins
file_owner=jenkins.jenkins

mkdir -p ${plugin_dir}

installPlugin() {
  if [ -f ${plugin_dir}/${1}.hpi -o -f ${plugin_dir}/${1}.jpi ]; then
    if [ "$2" == "1" ]; then
      return 1
    fi
    echo "Skipped: $1 (already installed)"
    return 0
  else
    echo "Installing: $1"
    sudo curl -L --silent --output ${plugin_dir}/${1}.hpi  ${UPDATES_URL}/${1}.hpi
    return 0
  fi
}

for plugin in $PLUGINS
do
  installPlugin "$plugin"
done

changed=1
maxloops=100

while [ "$changed"  == "1" ]; do
  echo "Check for missing dependecies ..."
  if  [ $maxloops -lt 1 ] ; then
    echo "Max loop count reached - probably a bug in this script: $0"
    exit 1
  fi
  ((maxloops--))
  changed=0
  for f in ${plugin_dir}/*.hpi ; do
    # without optionals
    #deps=$( unzip -p ${f} META-INF/MANIFEST.MF | tr -d '\r' | sed -e ':a;N;$!ba;s/\n //g' | grep -e "^Plugin-Dependencies: " | awk '{ print $2 }' | tr ',' '\n' | grep -v "resolution:=optional" | awk -F ':' '{ print $1 }' | tr '\n' ' ' )
    # with optionals
    deps=$(sudo unzip -p ${f} META-INF/MANIFEST.MF | tr -d '\r' | sed -e ':a;N;$!ba;s/\n //g' | grep -e "^Plugin-Dependencies: " | awk '{ print $2 }' | tr ',' '\n' | awk -F ':' '{ print $1 }' | tr '\n' ' ' )
    for plugin in $deps; do
      installPlugin "$plugin" 1 && changed=1
    done
  done
done

echo "fixing permissions"

chown ${file_owner} ${plugin_dir} -R

#service jenkins start > /dev/null 2>&1

echo "all done"