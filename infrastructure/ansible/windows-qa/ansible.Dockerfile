FROM centos:7

RUN yum update -y && \
    yum -y install epel-release && \
    yum -y update && \
    yum -y install ansible && \
    ansible --version &&\
    yum install -y python-pip  &&\
    pip install https://github.com/diyan/pywinrm/archive/master.zip#egg=pywinrm  &&\
    yum -y install gcc python-devel krb5-devel krb5-workstation  &&\
    pip install kerberos

WORKDIR /data    

ENV NAME ansible
ENV VERSION 1.0