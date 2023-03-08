#!/bin/bash
set -x

# bash -c "./hadoop-3.3.4/bin/hdfs namenode -format && ./hadoop-3.3.4/bin/hdfs --daemon start namenode && jps && sleep 999999d"
img="hadooptest"
net="spark-network"
host="master-node"
vol="hdfs-volume"

ports="-p 7077:7077 -p 8080:8080 -p 9000:9000 -p 9870:9870"
network="--network $net"
volume="-v $vol:/hdfs-data"
run="run $ports $network $volume $img"

format_namenode="./hadoop-3.3.4/bin/hdfs namenode -format"
start_namenode="./hadoop-3.3.4/bin/hdfs --daemon start namenode"
jps="jps"
sleep="sleep 999999d"

while getopts "fa" opt; do
  case $opt in
    f)
      echo "docker "
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done