# use label for meta data, and  not env
see also docker_init_sample which available with docker_init shell function

# @author Laurent Krishnathas

FROM golang:1.9.2-alpine3.7 as builder

LABEL maintainer="Laurent Krishnathas <lkdevjobs@googlemail.com>"
LABEL description="Adapted from https://github.com/oracle/docker-images/tree/master/OracleJava, download a server-jre before building"
LABEL build.dockerfile="dotfiles/oracle-jre-server/oracle-jre-server-8.Dockerfile"

RUN apk --no-cache add curl make
RUN apk --no-cache add git

RUN go get github.com/kubernetes/kompose
RUN rm -rf $GOPATH/bin
RUN go install github.com/kubernetes/kompose


#____________________________________________________________________________________________________
# Warning bug multi stage is reseting cache, uncomment after successful build
#FROM alpine:3.7 as runner
#ENV GOPATH /go
#COPY --from=builder /go/bin/kompose $GOPATH/bin/kompose

RUN $GOPATH/bin/kompose version
HEALTHCHECK CMD curl --fail http://127.0.0.1:8080/ || exit 1

ENTRYPOINT $GOPATH/bin/kompose
CMD ["version"]

LABEL image_name="laurent_krishnathas/kombose"
LABEL image_version="latest"
