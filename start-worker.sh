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
vol="hdfs-volume"

network="--network host"
volume="-v $vol:/hdfs-data"
hostname="--hostname $host"
name="--name $host"
run="run -d $network $volume $hostname $name $img"

start_datanode="hdfs --daemon start datanode"
start_spark_worker="\$SPARK_HOME/sbin/start-worker.sh spark://192.168.2.208:7077"
command="$start_datanode && $start_spark_worker"

echo -e ">>> docker -d $run sh -c \"$command\""
docker $run sh -c "$command"