#!/bin/bash

img="hadooptest"
net="spark-network"
host="master-node"
vol="hdfs-volume"

ports="-p 7077:7077 -p 8080:8080 -p 9000:9000 -p 9870:9870 -p 4040-4050:4040-4050"
network="--network $net"
volume="-v $vol:/hdfs-data"
hostname="--hostname $host"
name="--name $host"
run="run $ports $network $volume $hostname $name $img"

format_namenode="yes y | hdfs namenode -format"
start_namenode="hdfs --daemon start namenode"
jps="jps"
sleep="sleep 999999d"
command="$start_namenode && $jps && $sleep"

while getopts "f" opt; do
  case $opt in
    f)
      command="$format_namenode && $command"
      ;;
    \?)
      exit 1
      ;;
  esac
done

echo ">>> docker network create $net"
docker network create $net
echo -e ">>> docker $run sh -c \"$command\""
docker $run sh -c "$command"