FROM alpine:3.15

RUN apk add --no-cache bash curl aws-cli

COPY dir-backup.sh /
COPY backup.sh /

CMD [ "/backup.sh" ]
