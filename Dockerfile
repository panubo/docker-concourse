FROM debian:jessie

ENV CONCOURSE_VERSION=1.0.0

ADD https://github.com/concourse/concourse/releases/download/v${CONCOURSE_VERSION}/concourse_linux_amd64 /usr/local/bin/concourse
RUN chmod +x /usr/local/bin/concourse
ADD entry.sh /

ENTRYPOINT ["/entry.sh"]
CMD ["concourse"]
