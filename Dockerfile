FROM ubuntu:22.04

ENV HADOOP_HOME="/hadoop-3.3.4"
ENV SPARK_HOME="/usr/local/spark"
ENV SPARK_NO_DAEMONIZE="true"
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64/"
ENV PATH="${PATH}:$SPARK_HOME/bin:$HADOOP_HOME/bin"

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get install -y net-tools
RUN apt-get install -y wget
RUN apt-get install -y openjdk-11-jdk-headless
RUN wget -q https://dlcdn.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz
RUN tar -xvf hadoop-3.3.4.tar.gz
RUN rm hadoop-3.3.4.tar.gz

COPY hadoop-configs/core-site.xml /hadoop-3.3.4/etc/hadoop/
COPY hadoop-configs/hdfs-site.xml /hadoop-3.3.4/etc/hadoop/

# RUN ./hadoop-3.3.4/bin/hdfs namenode -format && ./hadoop-3.3.4/bin/hdfs --daemon start namenode && ./hadoop-3.3.4/bin/hdfs --daemon start datanode && bash


# RUN ${INSTALL} openjdk-8-jre-headless
# RUN ${INSTALL} scala
# RUN ${INSTALL} wget
# RUN ${INSTALL} screen
# # RUN ${INSTALL} python3
# # RUN ${INSTALL} python3-pip
# # RUN pip3 install pyspark==3.3.2
# ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64/"
# RUN wget https://archive.apache.org/dist/spark/spark-3.3.2/spark-3.3.2-bin-hadoop3.tgz
# RUN tar -xvf spark-3.3.2-bin-hadoop3.tgz
# RUN rm -rf spark-3.3.2-bin-hadoop3.tgz
# RUN mv spark-3.3.2-bin-hadoop3/ /usr/local/spark