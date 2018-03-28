FROM java:openjdk-8-jdk

MAINTAINER Laurent Krishnathas
LABEL maintainer Laurent Krishnathas<lkdevjobs@googlemail.com>

ENV JENKINS_SWARM_VERSION 2.2
ENV JENKINS_SWARM_DOWNLOAD_SITE https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client
ENV JENKINS_HOME /home/jenkins
ENV JENKINS_USER jenkins

RUN useradd -m -d "${JENKINS_HOME}" -u 1000 -U -s /sbin/nologin "${JENKINS_USER}"
RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-${JENKINS_SWARM_VERSION}-jar-with-dependencies.jar \
  ${JENKINS_SWARM_DOWNLOAD_SITE}/${JENKINS_SWARM_VERSION}/swarm-client-${JENKINS_SWARM_VERSION}-jar-with-dependencies.jar \
  && chmod 755 /usr/share/jenkins

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

RUN mkdir /docker-entrypoint-init.d
ONBUILD ADD ./*.sh /docker-entrypoint-init.d


RUN apt-get update -qq && \
  apt-get install -qq -y openjdk-8-jdk &&\

  # install utilities
     apt-get install -y \
     wget \
     curl \
     vim \
     git \
     zip \
     bzip2 \
     fontconfig \
     python \
     g++ \
     build-essential && \

  # install node.js
  curl -sL https://deb.nodesource.com/setup_6.x | bash && \
  apt-get install -qq -y nodejs && \

  # upgrade npm
  npm install -g npm && \

  # install yeoman bower gulp yarn
  npm install -g \
    yo \
    bower \
    gulp-cli \
    yarn && \

  # cleanup
  apt-get clean && \
  rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*



USER "${JENKINS_USER}"
VOLUME "${JENKINS_HOME}"

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]