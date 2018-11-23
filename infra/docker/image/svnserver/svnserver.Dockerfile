FROM krisdavison/svn-server:v2.0

RUN mkdir /scripts
WORKDIR /scripts

ADD ./init.sh  .
RUN sudo chmod +x init.sh
RUN sudo echo "store-plaintext-passwords = yes">>~/.subversion/servers

WORKDIR /home/svn

EXPOSE 22
EXPOSE 80
EXPOSE 443
EXPOSE 3690

CMD ["sh","-x", "/scripts/init.sh", "start"]
