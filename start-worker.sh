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
run="run $network $volume $hostname $name $img"

start_datanode="hdfs --daemon start datanode"
jps="jps"
sleep="sleep 999999d"
command="$start_datanode && $jps && $sleep"
command="$sleep"

echo -e ">>> docker $run sh -c \"$command\""
docker $run sh -c "$command"