# @author Laurent Krishnathas

FROM openjdk:8u151-jdk as builder

LABEL maintainer="Laurent Krishnathas <lkdevjobs@googlemail.com"

ARG ECLIPSE_URL='http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/oxygen/1a/eclipse-jee-oxygen-1a-linux-gtk-x86_64.tar.gz'

# curl | tar will not keep the tar file, so multi docker build is not needed
RUN mkdir -p /opt && curl $ECLIPSE_URL | tar -xz -C /opt

WORKDIR /code


LABEL image_name="laurent_krishnathas/eclipse"
LABEL image_version="jee-oxygen"


CMD ["/opt/eclipse/eclipse"]
