#!/bin/bash

echo -e ">>> cp -r ~/.ssh ."
cp -r ~/.ssh .

echo -e ">>> docker build -t hadooptest ."
docker build -t hadooptest .

echo -e ">>> rm -rf .ssh"
rm -rf .ssh