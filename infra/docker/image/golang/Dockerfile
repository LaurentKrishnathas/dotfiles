FROM 101999902141.dkr.ecr.eu-west-1.amazonaws.com/dotmatics-devops/amzlnx2_builder:1.1
MAINTAINER Laurent Krishnathas

# //TODO Move this to amzlnx2_builder itself, also add python
RUN  yum update -y \
    && yum install -y golang\
    && go version
