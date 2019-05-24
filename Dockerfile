FROM alpine:3.6
# We need the testing repo because of the shadow package.
#RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk update && apk add --no-cache dovecot shadow
# ADD dovecot-imap-ssl.conf /etc/dovecot/dovecot.conf
ADD dovecot-imap.conf /etc/dovecot/dovecot.conf
COPY run.sh /run.sh
EXPOSE 143
CMD /run.sh
