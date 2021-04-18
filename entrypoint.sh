#!/bin/sh
service cron start
tail --follow --retry /var/log/getmail/*.log
