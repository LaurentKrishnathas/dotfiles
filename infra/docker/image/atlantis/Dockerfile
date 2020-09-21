FROM runatlantis/atlantis:v0.15.0

ENV AWSCLI_VERSION "1.14.10"

RUN apk --no-cache update && \
    apk --no-cache add python3 py3-pip py-setuptools ca-certificates curl groff less && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/*
