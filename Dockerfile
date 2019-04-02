FROM sameersbn/ubuntu:14.04.20170123
MAINTAINER sameer@damagehead.com

ENV OPENFIRE_VERSION=4.3.2 \
    OPENFIRE_USER=openfire \
    OPENFIRE_DATA_DIR=/var/lib/openfire \
    OPENFIRE_LOG_DIR=/var/lib/openfire/logs

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-cache search openjdk \
 && apt-get install -y software-properties-common \
 && add-apt-repository -y ppa:openjdk-r/ppa \
 && apt-get update -y  \
 && apt-get install -y openjdk-8-jdk  \
 && java -version \
 && wget "http://download.igniterealtime.org/openfire/openfire_${OPENFIRE_VERSION}_all.deb" -O /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
 && dpkg -i /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
 && mv /var/lib/openfire/plugins/admin /usr/share/openfire/plugin-admin \
 && rm -rf openfire_${OPENFIRE_VERSION}_all.deb \
 && rm -rf /var/lib/apt/lists/*

COPY rccl-auth.jar ${OPENFIRE_DATA_DIR}/plugins/rcclauth.jar
COPY log4j.xml ${OPENFIRE_DATA_DIR}/log4j/log4j.xml
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3478/tcp 3479/tcp 5222/tcp 5223/tcp 5229/tcp 7070/tcp 7443/tcp 7777/tcp 9090/tcp 9091/tcp
VOLUME ["${OPENFIRE_DATA_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
