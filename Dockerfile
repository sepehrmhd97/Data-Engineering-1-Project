FROM hadoopbase

COPY hadoop-configs/core-site.xml /hadoop-3.3.4/etc/hadoop/
COPY hadoop-configs/hdfs-site.xml /hadoop-3.3.4/etc/hadoop/
COPY hadoop-configs/workers /hadoop-3.3.4/etc/hadoop/
COPY hadoop-configs/hadoop-env.sh /hadoop-3.3.4/etc/hadoop/
COPY hadoop-configs/spark-env.sh $SPARK_HOME/conf
COPY .ssh /root/.ssh

EXPOSE 7077
EXPOSE 8080
EXPOSE 9000
EXPOSE 9870
EXPOSE 4040-4050