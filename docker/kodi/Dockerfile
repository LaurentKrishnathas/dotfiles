FROM ubuntu:latest

RUN apt-get update && \
	apt-get install -y software-properties-common && \
	add-apt-repository ppa:team-xbmc/ppa && \
	apt-get update && \
	apt-get install -y kodi

ENV NAME kodi
ENV VERSION latest

CMD kodi

# WARNING: the created image is not working when run in docker as gui
# maybe not enough mem or cpu