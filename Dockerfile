# Inspired from https://github.com/justb4/docker-jmeter with JMeter plugin
FROM alpine:3.6

MAINTAINER Andi Santoso (asantoso@thetestguys.com)

ARG JMETER_VERSION="3.3"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV	JMETER_BIN ${JMETER_HOME}/bin
ENV	JMETER_DOWNLOAD_URL http://mirrors.ocf.berkeley.edu/apache/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

ARG TZ="Europe/Amsterdam"
RUN apk update && apk upgrade && apk add ca-certificates && update-ca-certificates && apk add --update openjdk8-jre tzdata curl unzip bash wget	&& rm -rf /var/cache/apk/* && mkdir -p /tmp/dependencies && curl -L --silent ${JMETER_DOWNLOAD_URL} > /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz && mkdir -p /opt && tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt && rm -rf /tmp/dependencies

RUN wget -O $JMETER_HOME/lib/ext/jmeter-plugins-manager.jar --trust-server-names https://jmeter-plugins.org/get/

RUN wget -O $JMETER_HOME/lib/cmdrunner-2.0.jar "http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/2.0/cmdrunner-2.0.jar"

RUN java -cp $JMETER_HOME/lib/ext/jmeter-plugins-manager.jar org.jmeterplugins.repository.PluginManagerCMDInstaller

RUN $JMETER_HOME/bin/PluginsManagerCMD.sh install jpgc-casutg,jpgc-prmctl,jpgc-graphs-basic,jpgc-graphs-additional,jpgc-tst

ENV PATH $PATH:$JMETER_BIN

COPY entrypoint.sh /

WORKDIR	${JMETER_HOME}

ENTRYPOINT ["/entrypoint.sh"]