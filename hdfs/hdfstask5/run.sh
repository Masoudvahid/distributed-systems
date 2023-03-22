#! /usr/bin/env bash

dd if=/dev/urandom of=file.txt bs=$1 count=1
hdfs dfs -Ddfs.replication=1 -put file.txt
hdfs fsck /user/hjudge/file.txt -files -blocks -locations | grep -i 'blk_' | while read line;
do
  block_id=`echo "$line" | cut -d: -f 2- | cut -d' ' -f1 | cut -d_ -f -2`;
  node_name=`hdfs fsck -blockId $block_id | head -12 | tail -1 | cut -d: -f 2- | awk '{print $1}' | sed -r 's|/.+||'`
  echo $node_name
  sudo -u hdfsuser ssh hdfsuser@$node_name "cd /dfs/; find -name $block_id" < /dev/null
done > temp_file
result=0
while read node;
do
  read path
  block_loc=`echo $path | awk '{print "/dfs"substr($0,2)}'`
  block_size=`sudo -u hdfsuser ssh hdfsuser@$node "ls -l $block_loc" < /dev/null | awk '{print $5}'`
  let "result = result + block_size"
done < temp_file
common_size=$1
let "result = common_size - result"
echo $result
rm temp_file
hdfs dfs -rm file.txt
rm file.txt
