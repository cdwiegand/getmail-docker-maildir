FROM debian:buster AS build

# have to fix stupid Windows-isms..
RUN apt-get update && apt-get install -y dos2unix
COPY getmail.cron /etc/cron.d/
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
RUN dos2unix /entrypoint.sh; dos2unix /etc/cron.d/getmail.cron

FROM debian:buster AS final
RUN apt-get update && apt-get install -y getmail cron && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY --from=build /etc/cron.d/getmail.cron /etc/cron.d/
COPY --from=build /entrypoint.sh /entrypoint.sh
VOLUME /etc/getmail
VOLUME /maildir

ENTRYPOINT /entrypoint.sh
CMD ["tail", "--follow", "--retry", "/var/log/getmail/*.log"]