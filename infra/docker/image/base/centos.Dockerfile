# @author Laurent Krishnathas
FROM centos:7

LABEL maintainer="Laurent Krishnathas <lkdevjobs@googlemail.com>"
LABEL description="centos"

# multi line left for caching
RUN yum update -y

RUN yum install -y \
    curl \
    git \
    git-core \
    subversion \
    unzip \
    vim \
    wget \
    zsh


RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || echo "no idea why the return value is 1"

ENTRYPOINT zsh

LABEL image_name="laurent_krishnathas/centos"
LABEL image_version="latest"