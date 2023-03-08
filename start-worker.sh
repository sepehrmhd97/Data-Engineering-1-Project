#!/bin/bash
set -x

has_host=false
while getopts "h:" opt; do
  case $opt in
    h)
      host=${OPTARG}
      has_host=true
      echo "Starting $host"
      ;;
    \?)
      exit 1
      ;;
  esac
done

if ! $has_host; then
  echo "Error: -h flag not provided." >&2
  exit 1
fi

img="hadooptest"
net="spark-network"
vol="hdfs-volume"

# ports="-p 7077:7077 -p 8080:8080 -p 9000:9000 -p 9870:9870 -p 4040-4050:4040-4050"
network="--network $net"
volume="-v $vol:/hdfs-data"
hostname="--hostname $host"
name="--name $host"
run="run $ports $network $volume $hostname $name $img"

start_namenode="./hadoop-3.3.4/bin/hdfs --daemon start datanode"
jps="jps"
sleep="sleep 999999d"
add_master="echo 192.168.2.208 master-node >> /etc/hosts"
command="$start_namenode && $jps && $add_master && $sleep"

docker network create $net
docker $run sh -c "$command"