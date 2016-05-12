FROM debian:jessie

RUN set -ex \
 && apt-get update \
 && apt-get install -y curl \
 && curl -sSL https://code.bitlbee.org/debian/release.key | apt-key add - \
 && echo "deb http://code.bitlbee.org/debian/master/jessie/amd64/ ./" > /etc/apt/sources.list.d/bitlbee \
 && apt-get update \
 && apt-get install -y bitlbee \
 && apt-get -y remove --purge curl \
 && apt-get -y autoremove

ADD start.sh /usr/local/bin/start.sh
ADD bitlbee.conf /etc/bitlbee/bitlbee.conf
ADD motd.txt /etc/bitlbee/motd.txt

USER bitlbee
VOLUME ["/data", "/var/lib/bitlbee"]
EXPOSE 6667/tcp
ENTRYPOINT ["/usr/local/bin/start.sh"]
