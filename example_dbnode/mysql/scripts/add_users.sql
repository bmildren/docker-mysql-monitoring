GRANT PROCESS, REPLICATION CLIENT ON *.* TO 'prometheus'@'%' IDENTIFIED BY 'prometheus';
GRANT SELECT ON performance_schema.* TO 'prometheus'@'%';
GRANT ALL PRIVILEGES ON sbtest.* TO 'sysbench'@'%' IDENTIFIED BY 'sysbench';
