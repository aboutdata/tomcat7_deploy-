#!/bin/sh
# 0. Verify war packages with jar
# 1. Stop Tomcat
# 2. Copy war packages to Tomcat webapps
# 3. Start Tomcatin

APPS="InternetHospitalWeb"
JAVA_HOME=/usr/local/jdk1.7.0_55
CATALINA_HOME=/usr/local/tomcat7.0.53-WEB
CATALINA_BASE=$CATALINA_HOME
TOMCAT_PORT=9080
TOMCAT_INIT_SCRIPT=$CATALINA_HOME/bin/catalina.sh
BASEDIR=$(cd "$(dirname "$0")"; pwd)

set -eu

# Include helper functions
source "$BASEDIR/deploy_functions.sh"

for artifact in $APPS; do
    echo -n "Checking $BASEDIR/$artifact.war for integrity: "
    if (( $(testWarIntegrity "$BASEDIR/$artifact.war") )); then
    echo " OK"
    else
    echo " Failed"
    cancelDeploy
    fi
done

echo "Stopping tomcat"
$TOMCAT_INIT_SCRIPT stop

echo "Waiting for tomcat to stop..."

if (( ! $(waitForListenerToClose $TOMCAT_PORT 20) )); then
    echo " Forcing tomcat to stop"
    $TOMCAT_INIT_SCRIPT stop -force

    if (( ! $(waitForListenerToClose $TOMCAT_PORT 20) )); then
        echo "Failed to stop tomcat."
    cancelDeploy
    fi
fi

echo "Tomcat stopped."

for artifact in $APPS; do

    echo "Deploying $artifact.war"

    temp_install_copy=$(mktemp /tmp/${artifact}XXXXXXXX.war)
    cp "$BASEDIR/$artifact.war" $temp_install_copy
    rm -f "$CATALINA_BASE/webapps/$artifact.war"
    rm -fr "$CATALINA_BASE/webapps/$artifact"
    cp $temp_install_copy "$CATALINA_BASE/webapps/$artifact.war"
    rm $temp_install_copy
done

echo "Starting tomcat"
set +eu
$TOMCAT_INIT_SCRIPT start

echo "Waiting for tomcat to start..."

if (( ! $(waitForListenerToStart $TOMCAT_PORT 120) )); then
    echo " Tomcat failed to start in time."
    cancelDeploy
fi

for artifact in $APPS; do
    url="http://localhost:${TOMCAT_PORT}/$artifact/login"
    echo "Waiting for $artifact to start... $url"
    until [ $(curl -sL -w '%{http_code}\n' "$url" -o /dev/null) == "200" ];
    do
        sleep 2
    done
done

echo "Deploy finished OK."
