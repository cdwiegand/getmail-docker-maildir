FROM debian:buster AS build

# have to fix stupid Windows-isms..
RUN apt-get update && apt-get install -y dos2unix
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
RUN dos2unix /entrypoint.sh

# final version
FROM debian:buster AS final
VOLUME /etc/getmail
VOLUME /maildir

RUN apt-get update && apt-get install -y getmail cron && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/log/getmail && touch /var/log/getmail/getmail.log
COPY --from=build /entrypoint.sh /entrypoint.sh

# create crontab entry
RUN (crontab -l -u root; echo "*/5 * * * *getmail -g /etc/getmail") | crontab

ENTRYPOINT /entrypoint.sh
