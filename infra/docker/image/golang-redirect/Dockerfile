FROM golang:1.9.2-alpine3.7 as builder
RUN mkdir /app
ADD infra/docker/image/golang-redirect/redirect.go /app/
WORKDIR /app
RUN env GOOS=linux GOARCH=386 go build -o redirect .


#FROM scratch
FROM alpine:3.7 as runner
RUN apk --no-cache add curl
ENV PORT 8080
HEALTHCHECK CMD curl --fail http://127.0.0.1:${PORT}/ || exit 1
COPY --from=builder /app/redirect /redirect
ENTRYPOINT ["/redirect"]
CMD []
