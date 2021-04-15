FROM debian:buster

VOLUME /etc/getmail
VOLUME /maildir
RUN apt-get update && apt-get install -y getmail cron && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY getmail.cron /etc/cron.d/
COPY entrypoint.sh /

ENTRYPOINT /entrypoint.sh
CMD ["tail", "--follow", "--retry", "/var/log/getmail/*.log"]