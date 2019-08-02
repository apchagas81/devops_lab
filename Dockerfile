FROM centos:centos7
#Dockerfile for Jenkins container creation
#MAINTAINER André Pereira César Chagas - apchagas81@gmail.com

# updating centos packages and installing needed dependencies
RUN yum update -y
RUN yum install -y unzip wget net-tools vim git

#Sending needed depedencies into the container
COPY jdk-8u221-linux-x64.tar.gz /tmp 
COPY jenkins.war /tmp
COPY startjks.sh /usr/local/bin
RUN chmod +x /usr/local/bin/startjks.sh

# Configuring JAVA and JENKINS
RUN mkdir -p /opt/app
RUN cd /tmp && tar zxvf jdk-8u221-linux-x64.tar.gz && mv jdk1.8.0_221 /opt/app
RUN chmod +x /opt/app/jdk1.8.0_221/bin*
RUN chmod +x /opt/app/jdk1.8.0_221/jre/bin*
RUN echo "Testing JAVA installation..."
RUN /opt/app/jdk1.8.0_221/bin/java -version
RUN mkdir -p /opt/app/jenkins
RUN cd /tmp && mv jenkins.war /opt/app/jenkins
RUN chmod +x /etc/profile.d/*

# Cleaning temporary folder
RUN cd /tmp && rm -rf *

# Exposing at least HTTP and JENKINS Application ports for this profile
EXPOSE 80 8080

CMD /bin/bash

# Script for Jenkins CI startup |startjks.sh|
# CMD ["startjks.sh"]
