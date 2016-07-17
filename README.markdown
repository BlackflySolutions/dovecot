# Dovecot IMAP SSL Docker.


## Quickstart:

Run the container with:

```
docker run -p 993:993 \
  -v /host/path/to/config:/config \
  -v /host/path/to/mail:/mail \
  -it theorician/dovecot
```

If you've followed the inital setup instructions below, you can now talk to your
IMAP server via SSL.

## SSL certificates

You need to have ssl certificates living at `/host/path/to/config` - wherever 
you wish that to be on your host. These get shared across to the Docker 
container as you can see in the command above. Change this to somewhere 
sensible.

The names are, for the public and private certificate files respectively: 
```
  /host/path/to/config/dovecot_cert_file.pem
  /host/path/to/config/dovecot_key_file.pem
```

If you have `openssl` installed on your host, you can generate the keys with:
```
  cd /host/path/to/config
  openssl genrsa -out dovecot_key_file.pem 2048
  openssl req -new -x509 -key dovecot_key_file.pem \
              -out dovecot_cert_file.pem -days 1095
```

## Virtual users

You need to create a passwd file for your virtual users. This file is of the 
format
```
  (username):(password with scheme):(uid):(gid)::(virtual home folder)
```
An example:
```
  user:{plain}password:1050:1050::/mail/user"
```

This file lives at `/host/path/to/config/dovecot.passwd`. 
