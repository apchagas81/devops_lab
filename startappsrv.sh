#!/bin/bash
export JAVA_HOME=/opt/app/jdk1.8.0_241
export CATALINA_HOME=/opt/app/apache-tomcat
export PATH=$CATALINA_HOME/bin:$PATH
export PATH
source $HOME/.bash_profile
bash /opt/app/apache-tomcat/bin/startup.sh
echo "|#Starting Tomcat Instance#|"
echo ".........."
echo ".........."
