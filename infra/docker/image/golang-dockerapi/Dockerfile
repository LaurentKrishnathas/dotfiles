FROM golang:1.9.2-alpine3.7 as builder
RUN apk update
RUN apk add git curl

# caching to make it faster
#RUN go get github.com/aws/aws-sdk-go/aws
#RUN go get github.com/aws/aws-sdk-go/aws/session
#RUN go get github.com/aws/aws-sdk-go/service/s3


#RUN go get github.com/docker/cli
#RUN go get github.com/docker/docker/api/types
#RUN go get github.com/docker/docker/client
#RUN go get 	github.com/moby/moby/api
#RUN go get docker.io/go-docker
#RUN go get -d docker.io/go-docker

WORKDIR /go/src/github.com/laurentkrishnathas/golang
#RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

ADD infra/docker/image/golang-dockerapi/main.go .
#RUN dep init

#RUN pwd
#RUN find .
#RUN ls -la .
#RUN dep ensure -add docker.io/go-docker@v1


RUN go get -v ./
RUN env GOOS=linux GOARCH=386 go build -o /app .

FROM alpine:3.7 as runner
RUN apk --no-cache add curl
COPY --from=builder /app /app

CMD /app
