FROM debian:stretch

COPY bitlbee.list /etc/apt/sources.list.d/bitlbee.list

RUN set -ex \
 && apt-get update \
 && apt-get install -y --no-install-recommends gnupg2 curl ca-certificates \
 && curl -sSfL https://code.bitlbee.org/debian/release.key | apt-key add - \
 && curl -sSfL https://jgeboski.github.io/obs.key | apt-key add - \
 && apt-get update \
 && apt-get install -y --no-install-recommends bitlbee bitlbee-steam \
 && apt-get purge -y gnupg2 curl \
 && apt-get -y autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


COPY start.sh /usr/local/bin/start.sh
COPY bitlbee.conf /etc/bitlbee/bitlbee.conf
COPY motd.txt /etc/bitlbee/motd.txt

USER bitlbee
VOLUME ["/data", "/var/lib/bitlbee"]
EXPOSE 6667/tcp
ENTRYPOINT ["/usr/local/bin/start.sh"]
