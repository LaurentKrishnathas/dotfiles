FROM golang:1.9.2-alpine3.7 as builder
RUN apk update && apk add git

# caching to make it faster
RUN go get github.com/aws/aws-sdk-go/aws
RUN go get github.com/aws/aws-sdk-go/aws/session
RUN go get github.com/aws/aws-sdk-go/service/s3

WORKDIR /go/src/github.com/laurentkrishnathas/s3list

ADD infra/docker/image/golang-aws-s3list/ .

RUN go get -v ./
RUN env GOOS=linux GOARCH=386 go build -o /app .

FROM alpine:3.7 as runner
RUN apk --no-cache add curl
COPY --from=builder /app /app

CMD /app
