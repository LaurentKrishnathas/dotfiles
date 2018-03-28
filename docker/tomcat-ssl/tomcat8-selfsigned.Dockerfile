# https with Tomcat and self signed keystore.jks

FROM tomcat:8
MAINTAINER Laurent Krishnathas

COPY data/selfsigned.keystore.jks /security/keystore.jks
COPY data/tomcat8-selfsigned-server.xml /usr/local/tomcat/conf/server.xml

EXPOSE 8080
EXPOSE 8443

ENV VERSION 8-selfsigned-0.3
ENV NAME tomcat-ssl

CMD ["catalina.sh", "run"]

