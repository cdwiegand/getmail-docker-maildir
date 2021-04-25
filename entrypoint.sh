#!/bin/sh
service cron start
touch /var/log/getmail/getmail.log
tail -f /var/log/getmail/getmail.log
