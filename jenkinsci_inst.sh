#!/bin/bash
#
#
now=`date +%Y%m%d`
docker_dir="/opt/app/docker_lab"
#--------------------------------------------------------------------------------------------------------------------------
echo "creating rfm_docker directory"
sudo mkdir -p $docker_dir
sudo chown -R labuser.labuser $docker_dir
#--------------------------------------------------------------------------------------------------------------------------
cd $docker_dir
wget https://rfm2oregon.s3-us-west-2.amazonaws.com/jdk-8u221-linux-x64.tar.gz
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
wget https://rfm2oregon.s3-us-west-2.amazonaws.com/startjks.sh
echo "building a docker container....   "
sudo docker build -t vm-lab-jks-$now $docker_dir
echo "Running the first container after provision process..... "
sudo docker run -d -i -t --name vm-lab-jks-001 --hostname vm-lab-jks-001 -v /opt/app:/opt/app -p 8080:8080 -p 80:80 vm-lab-jks-$now /bin/bash
echo "To connect to the container, run the following as root: docker exec -ti vm-lab-jks-001 /bin/bash....   "
echo "To run a new container, type the following command in example: sudo docker run -d -i -t --name vm-lab-jks-002 --hostname vm-lab-jks-002 -v $app_home:$app_home -p 8081:8080 -p 81:80 vm-lab-jks-$now /bin/bash....   "
echo "script finished at $now"
