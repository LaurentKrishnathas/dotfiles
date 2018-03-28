# @author Laurent Krishnathas
FROM golang:1.9.2-alpine3.7 as builder

LABEL maintainer="Laurent Krishnathas <lkdevjobs@googlemail.com>"
LABEL description="kombose build from source code"

RUN apk --no-cache add git

RUN go get github.com/kubernetes/kompose
RUN rm -rf /go/bin
RUN go install github.com/kubernetes/kompose


#____________________________________________________________________________________________________
FROM alpine:3.7
COPY --from=builder /go/bin/kompose /go/bin/kompose

RUN /go/bin/kompose version

ENTRYPOINT ["/go/bin/kompose"]
CMD ["version"]

LABEL image_name="laurent_krishnathas/kompose"
LABEL image_version="latest"

