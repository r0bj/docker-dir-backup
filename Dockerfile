FROM alpine:3.13

ENV S3CMD_VERSION 2.1.0

RUN apk add --no-cache bash curl py3-setuptools \
  && wget -q https://github.com/s3tools/s3cmd/releases/download/v${S3CMD_VERSION}/s3cmd-${S3CMD_VERSION}.tar.gz \
  && tar xvpzf s3cmd-${S3CMD_VERSION}.tar.gz \
  && rm -f s3cmd-${S3CMD_VERSION}.tar.gz \
  && cd s3cmd-${S3CMD_VERSION} \
  && python3 setup.py install \
  && cd .. \
  && rm -rf s3cmd-${S3CMD_VERSION}

COPY dir-backup.sh /
COPY backup.sh /

CMD [ "/backup.sh" ]
