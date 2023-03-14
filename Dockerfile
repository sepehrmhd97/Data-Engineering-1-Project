FROM ubuntu:22.04 AS hadoop-builder

ENV HADOOP_HOME="/hadoop-3.3.4"
ENV SPARK_HOME="/usr/local/spark"
ENV SPARK_NO_DAEMONIZE="true"
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64/"
ENV PATH="${PATH}:$SPARK_HOME/bin:$HADOOP_HOME/bin"
ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y net-tools
RUN apt-get install -y iputils-ping
RUN apt-get install -y wget
RUN apt-get install -y openjdk-11-jdk-headless
RUN apt-get install -y openssh-client
RUN wget -q https://dlcdn.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz
RUN tar -xvf hadoop-3.3.4.tar.gz
RUN rm hadoop-3.3.4.tar.gz

COPY hadoop-configs/core-site.xml /hadoop-3.3.4/etc/hadoop/
COPY hadoop-configs/hdfs-site.xml /hadoop-3.3.4/etc/hadoop/
COPY hadoop-configs/workers /hadoop-3.3.4/etc/hadoop/
COPY hadoop-configs/hadoop-env.sh /hadoop-3.3.4/etc/hadoop/

EXPOSE 7077
EXPOSE 8080
EXPOSE 9000
EXPOSE 9870
EXPOSE 4040-4050
