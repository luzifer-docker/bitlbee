FROM debian:jessie

ADD https://code.bitlbee.org/debian/release.key /tmp/bitlbee_release.key
ADD bitlbee.list /etc/apt/sources.list.d/bitlbee.list

RUN set -ex \
 && apt-key add /tmp/bitlbee_release.key \
 && apt-get update \
 && apt-get install -y bitlbee \
 && apt-get -y autoremove

ADD start.sh /usr/local/bin/start.sh
ADD bitlbee.conf /etc/bitlbee/bitlbee.conf
ADD motd.txt /etc/bitlbee/motd.txt

USER bitlbee
VOLUME ["/data", "/var/lib/bitlbee"]
EXPOSE 6667/tcp
ENTRYPOINT ["/usr/local/bin/start.sh"]
