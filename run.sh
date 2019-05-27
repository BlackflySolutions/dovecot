#!/bin/sh

die () {
  echo >&2 "$@"
  exit 1
}

syslogd

PUID=${PUID:-5000}
PGID=${PGID:-5000}

id dovecot 2>/dev/null
[ ! $? -eq 0 ] && addgroup -g $PGID dovecot && adduser -u $PUID -G dovecot -D -s /bin/sh dovecot

if [ ! "$(id -u dovecot)" -eq "$PUID" ]; then usermod -o -u "$PUID" dovecot ; fi
if [ ! "$(id -g dovecot)" -eq "$PGID" ]; then groupmod -o -g "$PGID" dovecot ; fi
mkdir /config
echo "${VSITE_CIVIMAIL_USER}:{plain}${VSITE_CIVIMAIL_PASS}:${PUID}:${GUID}::/civimail" > /config/dovecot.passwd
chown -R dovecot:dovecot /config

if [ ! -f "/config/dovecot.passwd" ]; then
  die "/config/dovecot.passwd does not exist - please create it. an example: 
  (username):(password with scheme):(uid):(gid)::(virtual home folder)
  user:{plain}password:1050:1050::/mail/user"
fi

/usr/sbin/dovecot
tail -f /var/log/messages
