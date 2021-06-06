FROM debian:buster
VOLUME /etc/getmail
VOLUME /maildir

# keep this step small!
RUN apt-get update && apt-get install -y getmail cron && apt-get clean && rm -rf /var/lib/apt/lists/*

# create crontab entry
RUN echo "*/5 * * * * getmail -g /etc/getmail" >> /etc/cron.d/getmail-crontab

# getmail complains if logfile can't exist, so create folder
RUN mkdir -p /var/log/getmail

ENTRYPOINT ["cron","-f"]
