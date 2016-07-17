FROM alpine:3.3
MAINTAINER theorician

# We need the testing repo because of the shadow package.
RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk update && apk add --no-cache dovecot shadow

EXPOSE 993

VOLUME ["/config", "/mail"]

ADD run.sh /run.sh

CMD /run.sh