#!/bin/bash
export JAVA_HOME=/opt/app/jdk1.8.0_221
export JKS_HOME=/opt/app/jenkins
PATH=$PATH:$JAVA_HOME/bin
export PATH
echo "|#Starting Jenkin#|"
echo ".........."
echo ".........."
nohup java -jar $JKS_HOME/jenkins.war --httpPort=8080 &
