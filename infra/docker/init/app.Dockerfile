# @author Laurent Krishnathas
# @version 2017/10/19

# builder -----------------------------------------------------------------------------------------------
# base named image with specific version
FROM alpine:3.6 as builder  

# these layers were left intentionally to use docker build cache to make the whole build quicker 
RUN apk update
RUN apk add curl
RUN apk add make

WORKDIR /root/

# copy command over add command to avoid surprise
COPY Makefile .

# runtime -----------------------------------------------------------------------------------------------
# scratch base may not have basic tools
FROM alpine:3.6

# Labels are prefered over ENV to avoid container pollution and colution
LABEL maintainer="Laurent Krishnathas <<lkdevjobs@googlemail.com>>"
LABEL description=""

RUN apk --no-cache add curl make

HEALTHCHECK CMD curl --fail http://127.0.0.1:8080/ || exit 1

COPY --from=builder /root/Makefile .

CMD ["make", "hello"] 