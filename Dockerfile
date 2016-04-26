FROM debian:jessie

ENV CONCOURSE_VERSION=1.1.0

# CA Certs required for ssl
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

ADD https://github.com/concourse/concourse/releases/download/v${CONCOURSE_VERSION}/concourse_linux_amd64 /usr/local/bin/concourse
RUN chmod +x /usr/local/bin/concourse
ADD entry.sh /

ENTRYPOINT ["/entry.sh"]
CMD ["concourse"]
