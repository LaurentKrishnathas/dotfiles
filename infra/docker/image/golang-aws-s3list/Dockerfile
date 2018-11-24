FROM golang:1.9.2-alpine3.7 as builder
RUN apk update
RUN apk add git
RUN go get github.com/aws/aws-sdk-go/aws
WORKDIR /app
ADD infra/docker/image/golang-aws-s3list/s3list.go .
RUN env GOOS=linux GOARCH=386 go build -o s3list .

FROM alpine:3.7 as runner
RUN apk --no-cache add curl
COPY --from=builder /app/s3list /s3list
ENTRYPOINT ["/s3list"]
CMD []
