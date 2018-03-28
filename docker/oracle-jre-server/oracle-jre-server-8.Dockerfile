# LICENSE CDDL 1.0 + GPL 2.0
#
# Copyright (c) 2015 Oracle and/or its affiliates. All rights reserved.
#
FROM oraclelinux:7-slim
LABEL maintainer="Laurent Krishnathas <lkdevjobs@googlemail.com>"
LABEL description="Adapted from https://github.com/oracle/docker-images/tree/master/OracleJava, download a server-jre before building"
LABEL build.dockerfile="dotfiles/oracle-jre-server/oracle-jre-server-8.Dockerfile"
ARG GIT_COMMIT=unkown
LABEL build.git-commit=$GIT_COMMIT    


ENV JAVA_PKG=server-jre-8u*-linux-x64.tar.gz \
    JAVA_HOME=/usr/java/default

ADD $JAVA_PKG /usr/java/

RUN export JAVA_DIR=$(ls -1 -d /usr/java/*) && \
    ln -s $JAVA_DIR /usr/java/latest && \
    ln -s $JAVA_DIR /usr/java/default && \
    alternatives --install /usr/bin/java java $JAVA_DIR/bin/java 20000 && \
    alternatives --install /usr/bin/javac javac $JAVA_DIR/bin/javac 20000 && \
    alternatives --install /usr/bin/jar jar $JAVA_DIR/bin/jar 20000

ENV NAME oracle-jre
ENV VERSION 8u144

