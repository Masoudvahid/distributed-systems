add jar /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;

USE masoudva;


SELECT Query, COUNT(DISTINCT Http_status_code) AS status_count
FROM Logs
GROUP BY Query
ORDER BY status_count DESC;
