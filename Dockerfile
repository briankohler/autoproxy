FROM alpine:3.3

RUN apk add --update socat curl apk-cron ruby rsyslog haproxy \
    && gem install filewatcher --no-ri --no-rdoc \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /usr/lib/autoproxy \
    && mkdir -p /etc/rsyslog.d \
    && echo "local2.*    /dev/stdout" >> /etc/rsyslog.d/haproxy.conf  \
    && echo '*/5 * * * * /var/getbackups.sh' > /var/spool/cron/crontabs/root \
    && curl -L https://github.com/sequenceiq/docker-alpine-dig/releases/download/v9.10.2/dig.tgz | tar -xzv -C /usr/local/bin/

COPY ./cleanup.sh /var/cleanup.sh
COPY ./drainbackend.sh /usr/local/bin/drainbackend.sh
COPY ./readybackend.sh /usr/local/bin/readybackend.sh
COPY ./getbackups.sh /var/getbackups.sh
COPY ./rsyslog.conf /etc/rsyslog.conf
COPY ./lib/* /etc/autoproxy.d/configs/
COPY ./bin/autoproxy /bin/autoproxy
COPY ./bin/entrypoint.sh /bin/entrypoint.sh

VOLUME ["/etc/autoproxy.d/services"]
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["/bin/autoproxy"]

