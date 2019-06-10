FROM amazonlinux:2.0.20190508

MAINTAINER lk@dotmatics.com <Laurent Krishnathas>

# Using script to build both docker image and ami
# Script modif will unset the docker cache but worth it, remove layer and save 1g disk space

ENV INSTALL_DIR infra/docker/image/amzlnx2_builder/provisioner

ENV INSTALL_FILE1 01_install_yum_dep.bash
ADD $INSTALL_DIR/$INSTALL_FILE1 /amzlnx2_builder/provisioner/$INSTALL_FILE1
RUN sed 's/sudo//' /amzlnx2_builder/provisioner/$INSTALL_FILE1 | bash

ENV INSTALL_FILE2 02_install_infra_tools.bash
ADD $INSTALL_DIR/$INSTALL_FILE2 /amzlnx2_builder/provisioner/$INSTALL_FILE2
RUN sed 's/sudo//' /amzlnx2_builder/provisioner/$INSTALL_FILE2 | bash

# install Dockerfile specific
#install oracle jdk from downloaded file from aws s3
ADD build/jdk-8u172-linux-x64.tar.gz /usr/java
RUN which java || true \
    && ls -la `which java ` \
    && ln -s /usr/java/jdk1.8.0_172/bin/java /usr/bin/java \
    && which java  \
    && ls -la `which java `\
    && java -version

ADD infra/docker/image/amzlnx2_builder/goss /goss
RUN goss -g /goss/goss-buildtime.yaml validate

#HEALTHCHECK --interval=1s --timeout=6s CMD goss -g /goss/healthcheck.yaml validate

