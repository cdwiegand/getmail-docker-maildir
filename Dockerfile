FROM debian:bookworm-20240211-slim
VOLUME /etc/getmail
VOLUME /maildir

# keep this step small!
RUN apt-get update && apt-get install -y getmail6 && apt-get clean && rm -rf /var/lib/apt/lists/*

# put file
COPY run.sh /

# getmail complains if logfile can't exist, so create folder
RUN mkdir -p /var/log/getmail

ENTRYPOINT ["/bin/bash","/run.sh"]
