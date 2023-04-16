add jar /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;

USE masoudva;


SELECT  Web_browser,
        COUNT(CASE WHEN Gender='male' THEN 1 ELSE 0 END) as MaleCount,
        COUNT(CASE WHEN Gender='female' THEN 1 ELSE 0 END) as FemaleCount
FROM Users
GROUP BY Web_browser;
