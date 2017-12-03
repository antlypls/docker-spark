FROM openjdk:jre-alpine

RUN apk add --update unzip wget coreutils bash

ENV SPARK_VERSION 2.2.1
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-hadoop2.7
ENV SPARK_HOME /opt/spark-${SPARK_VERSION}
ENV PATH $PATH:${SPARK_HOME}/bin

RUN mkdir /opt && wget -q "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" -O "/tmp/${SPARK_PACKAGE}.tgz" \
  && tar xfz /tmp/${SPARK_PACKAGE}.tgz -C /opt \
  && mv /opt/$SPARK_PACKAGE $SPARK_HOME \
  && rm /tmp/${SPARK_PACKAGE}.tgz

WORKDIR $SPARK_HOME

CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]
