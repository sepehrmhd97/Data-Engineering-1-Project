FROM ubuntu:22.04

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
RUN apt-get install -y wget
RUN apt-get install -y openjdk-11-jdk-headless
RUN apt-get install -y openssh-client
RUN wget -q https://dlcdn.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz
RUN tar -xvf hadoop-3.3.4.tar.gz
RUN rm hadoop-3.3.4.tar.gz

RUN apt-get install -y scala
RUN apt-get install -y screen
RUN wget -q https://archive.apache.org/dist/spark/spark-3.3.2/spark-3.3.2-bin-hadoop3.tgz
RUN tar -xvf spark-3.3.2-bin-hadoop3.tgz
RUN mv spark-3.3.2-bin-hadoop3/ /usr/local/spark
RUN rm spark-3.3.2-bin-hadoop3.tgz
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN pip3 install pyspark==3.3.2

COPY config/core-site.xml /hadoop-3.3.4/etc/hadoop/
COPY config/hdfs-site.xml /hadoop-3.3.4/etc/hadoop/
COPY config/workers /hadoop-3.3.4/etc/hadoop/
COPY config/hadoop-env.sh /hadoop-3.3.4/etc/hadoop/
COPY config/spark-env.sh $SPARK_HOME/conf
COPY .ssh /root/.ssh

EXPOSE 7077
EXPOSE 8080
EXPOSE 9000
EXPOSE 9870
EXPOSE 4040-4050