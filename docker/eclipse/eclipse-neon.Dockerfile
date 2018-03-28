FROM java 

LABEL maintainer="Laurent Krishnathas <lkdevjobs@googlemail.com"

ARG ECLIPSE_URL='http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/neon/R/eclipse-java-neon-R-linux-gtk-x86_64.tar.gz'
RUN mkdir -p /opt && curl $ECLIPSE_URL | tar -xvz -C /opt

CMD ["/opt/eclipse/eclipse"]

ENV NAME laurent_krishnathas/eclipse
ENV VERSION neon

