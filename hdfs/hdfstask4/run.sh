#! /usr/bin/env bash

param=$1
node_name=`hdfs fsck -blockId $1 | head -12 | tail -1 | cut -d: -f 2- | awk '{print $1}' | sed -r 's|/.+||'`
loc_name=`sudo -u hdfsuser ssh hdfsuser@$node_name "locate $param && exit" | head -n 1`
echo $node_name:$loc_name