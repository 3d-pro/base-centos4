#/bin/bash

rm -rf /var/run/rsyslogd.pid
service rsyslog start
cron
/usr/sbin/sshd -D
