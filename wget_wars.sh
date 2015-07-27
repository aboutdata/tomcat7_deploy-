#!/bin/bash
APPS=( "InternetHospitalWeb|http://192.168.10.206:8080/jenkins/job/InternetHospitalWeb/ws/target/InternetHospitalWeb-0.0.1-SNAPSHOT.war")

BASEDIR=$(cd "$(dirname "$0")"; pwd)

source "$BASEDIR/deploy_functions.sh"

set -eu

BROKEN_ARTIFACTS=0
for app in ${APPS[@]} ; do
  artifact=${app%%|*}
  url=${app##*|}
  wget $url -O "$BASEDIR/$artifact.war"
  if (( ! $(testWarIntegrity "$BASEDIR/$artifact.war") )); then
    BROKEN_ARTIFACTS=1
    echo "Broken artifact received for $artifact.war"
    break
  fi
done

if (( $BROKEN_ARTIFACTS )); then
  for app in ${APPS[@]} ; do
    artifact=${app%%|*}
    echo "Removing $BASEDIR/$artifact.war"
    rm -f "$BASEDIR/$artifact.war"
  done
  echo "Error in getting all artifacts. All artifacts deleted."
  exit 1
fi
