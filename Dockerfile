FROM java:openjdk-8u111-alpine

MAINTAINER lordvlad

ENV ADS_VERSION=2.0.0-M24

RUN add --update bash
  && rm -rf /var/cache/apk/*

ADD http://apache.mirrors.hoobly.com//directory/apacheds/dist/${ADS_VERSION}/apacheds-${ADS_VERSION}.tar.gz /tmp/apacheds.tgz

RUN mkdir /opt
RUN tar -C /opt -xf /tmp/apacheds.tgz && rm /tmp/apacheds.tgz

ENV ADS_INSTANCES=/ads \
    ADS_HOME=/opt/apacheds-${ADS_VERSION}

# The default ports as described at http://directory.apache.org/apacheds/advanced-ug/1.2-network.html
EXPOSE 10389 10636 60088 60464 8080 8443

WORKDIR $ADS_HOME
RUN mkdir $ADS_INSTANCES && cp -r instances/default $ADS_INSTANCES

VOLUME ["/ads"]

ENTRYPOINT ["bin/apacheds.sh","run"]
