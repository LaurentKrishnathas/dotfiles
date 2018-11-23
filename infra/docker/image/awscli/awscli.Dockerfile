FROM alpine:3.6

LABEL maintainer="Laurent Krishnathas <lkbis2009@googlemail.com>"
LABEL description="A awscli in docker"

ENV SERVER_USER awscli 
ENV SERVER_GROUP awscli

ENV HOME /awscli 

ENV	CRON_SCRIPT /script.sh 
ENV	CROND_REGEX "* * * * *" 
ENV	CROND_ARGS "-l 8"

WORKDIR $HOME

# apk add --update busybox-suid  was used due to failure in crond
RUN	mkdir -p /aws && \
	apk -Uuv add groff less python py-pip && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/* && \
	apk add --update busybox-suid &&\
	addgroup $SERVER_GROUP &&\
	adduser -G $SERVER_USER -D -h $HOME $SERVER_USER &&\
	chown -R $SERVER_USER:$SERVER_GROUP $HOME

COPY script.sh /script.sh
COPY docker-entrypoint.sh /docker-entrypoint.sh


CMD ["/docker-entrypoint.sh"]

