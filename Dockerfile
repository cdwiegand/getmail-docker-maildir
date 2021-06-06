FROM debian:buster
VOLUME /etc/getmail
VOLUME /maildir

# keep this step small!
RUN apt-get update && apt-get install -y getmail cron && apt-get clean && rm -rf /var/lib/apt/lists/*

# create crontab entry
RUN echo "*/5 * * * * getmail -g /etc/getmail" >> /etc/cron.d/getmail-crontab
RUN mkdir -p /var/log/getmail; ln -s /dev/stdout /var/log/getmail/getmail.log

ENTRYPOINT ["cron","-f"]
