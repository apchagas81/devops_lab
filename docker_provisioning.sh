#!/bin/bash
#############################################################################
# This script is for implementing docker containerized application servers. #
# Contact: Andre Pereira Cesar Chagas - +55(11)976034663                    #
# E-mails: alm2.servicos.ti@gmail.com / apchagas81@gmail.com                #
#############################################################################
#
# Variable Environment Settings
export img_version=`date +%Y%m%d`
export docker_dir="/opt/app/docker"
export s3_alm2="alm2-gerdal.s3.amazonaws.com"
#---------------------------------------------------
echo "==================================================="
echo "1st step: Creating docker directory..."
echo "==================================================="
sudo mkdir -p $docker_dir
sudo chown -R labadmin.labadmin $docker_dir
#---------------------------------------------------
echo "==================================================="
echo "2nd step: Downloading Needed Dependencies..."
echo "==================================================="
cd $docker_dir
wget https://$s3_alm2/jdk-8u241-linux-x64.tar.gz
wget https://$s3_alm2/apache-maven-3.6.3-bin.zip
wget https://$s3_alm2/apache-tomcat-8.5.53.zip
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
wget https://$s3_alm2/Dockerfile1
wget https://$s3_alm2/Dockerfile2
wget https://$s3_alm2/startjks.sh
wget https://$s3_alm2/startappsrv.sh
wget https://$s3_alm2/jks_bash_profile
wget https://$s3_alm2/tcat_bash_profile
wget https://$s3_alm2/context.xml
wget https://$s3_alm2/tomcat-users.xml
#---------------------------------------------------
echo "==================================================="
echo "3rd step: Building docker containers..."
echo "==================================================="
mv Dockerfile1 Dockerfile
sudo docker build -t alm2-jks-$img_version $docker_dir
echo "Running the first container after provision process..... "
sudo docker run -d -i -t --name alm2-jks-001 --hostname alm2-jks-001 -p 8080:8080 alm2-jks-$img_version /bin/bash
echo "To connect to the container, run the following as root: docker exec -ti alm2-jks-001 /bin/bash....   "
echo "To run a new container, type the following command in example: sudo docker run -d -i -t --name alm2-002 --hostname alm2-jks-002 8081:8080 alm2-jks-$img_version /bin/bash....   "
mv Dockerfile Dockerfile1
mv Dockerfile2 Dockerfile
sudo docker build -t alm2-appsrv-$img_version $docker_dir
echo "Running the first tomcat container after provision process..... "
sudo docker run -d -i -t --name alm2-appsrv-001 --hostname alm2-appsrv-001 -v /opt/app:/opt/app -p 9080:8080 -p 80:80 alm2-appsrv-$img_version /bin/bash
sudo docker run -d -i -t --name alm2-appsrv-002 --hostname alm2-appsrv-002 -v /opt/app:/opt/app -p 9085:8080 -p 85:80 alm2-appsrv-$img_version /bin/bash
echo "starting Tomcat Server ..." && docker exec alm2-appsrv-001 startup.sh && docker exec alm2-appsrv-002 startup.sh
echo "To connect to the container, run the following as root: docker exec -ti alm2-appsrv-001 /bin/bash....   "
echo "To run a new container, type the following command in example: docker run -d -i -t --name alm2-appsrv-003 --hostname alm2-appsrv-003 -v /opt/app:/opt/app -p 9086:8080 -p 86:80 alm2-appsrv-$img_version /bin/bash....   "
#---------------------------------------------------
echo "==================================================="
echo "4th step: Removing $docker_dir..."
echo "==================================================="
rm -rf $docker_dir
echo ""
echo ""
echo "Process finished at $(date)"
