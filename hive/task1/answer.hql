add jar /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;

set hive.exec.max.dynamic.partitions=5000;
set hive.exec.max.dynamic.partitions.pernode=1000;

USE masoudva;



DROP TABLE IF EXISTS user_logs_temp;

CREATE EXTERNAL TABLE user_logs_temp (
    IP STRING,
    Query BIGINT,
    Http_request_body STRING,
    Size SMALLINT,
    Http_status_code SMALLINT,
    Info STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
    "input.regex" = '^(\\S*)\\t\\t\\t(\\d{8})\\S*\\t(\\S*)\\t(\\d*)\\t(\\d*)\\t(\\S*?(?=\\s)).*$'
)
STORED AS TEXTFILE
LOCATION '/data/user_logs/user_logs_M';



DROP TABLE IF EXISTS Users;

CREATE EXTERNAL TABLE Users (
    IP STRING,
    Web_browser STRING,
    Gender STRING,
    AGE INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
    "input.regex" = "(.+)\\s(.+)\\s(.+)\\t(.+)$"
)
STORED AS TEXTFILE
LOCATION '/data/user_logs/user_data_M';

SELECT * from Users limit 10;



DROP TABLE IF EXISTS IPRegions;

CREATE EXTERNAL TABLE IPRegions (
    IP STRING,
    Region STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
    "input.regex" = "(.+)\\t(.+)$"
)
STORED AS TEXTFILE
LOCATION '/data/user_logs/ip_data_M';

SELECT * from IPRegions limit 10;



SET hive.exec.dynamic.partition.mode=nonstrict;

DROP TABLE IF EXISTS Logs;

CREATE EXTERNAL TABLE Logs (
    IP STRING,
    Http_request_body STRING,
    Size SMALLINT,
    Http_status_code SMALLINT,
    Info STRING
)
PARTITIONED BY (Query BIGINT)
STORED AS TEXTFILE;

INSERT OVERWRITE TABLE Logs PARTITION (Query)
SELECT IP, Http_request_body, Size, Http_status_code, Info, Query from user_logs_temp;


SELECT * from Logs limit 10;
