#!/bin/sh
service cron start
touch /var/log/getmail/getmail.log
echo "Starting cron as of `date`"
tail -f /var/log/getmail/getmail.log
