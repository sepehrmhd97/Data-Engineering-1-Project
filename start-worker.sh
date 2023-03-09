#!/bin/bash

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
master_address="192.168.2.208"

# ports="-p 7077:7077 -p 8080:8080 -p 9000:9000 -p 9870:9870 -p 4040-4050:4040-4050"
network="--network $net"
volume="-v $vol:/hdfs-data"
hostname="--hostname $host"
name="--name $host"
run="run $network $volume $hostname $name $img"

edithost="echo $master_address master-node >> /etc/hosts"
start_datanode="hdfs --daemon start datanode"
jps="jps"
sleep="sleep 999999d"
command="$edithost && $start_datanode && $jps && $sleep"

echo ">>> docker network create $net"
docker network create $net
echo -e ">>> docker $run sh -c \"$command\""
docker $run sh -c "$command"