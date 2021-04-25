#!/bin/sh
service cron start
touch /var/log/getmail/getmail.log
echo "Starting getmail as of `date`"
tail -f /var/log/getmail/getmail.log
