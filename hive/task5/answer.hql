add jar /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;

set hive.exec.max.dynamic.partitions=5000;
set hive.exec.max.dynamic.partitions.pernode=1000;

USE masoudva;

SELECT TRANSFORM(IP, Query, Http_request_body, Size, Http_status_code, Info)
USING "sed 's/http/ftp/'" AS IP, Query, Http_request_body, Size, Http_status_code, Info
FROM Logs
LIMIT 10;
