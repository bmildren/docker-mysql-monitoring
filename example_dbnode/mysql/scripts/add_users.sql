GRANT REPLICATION CLIENT, PROCESS, SUPER, SELECT ON *.* TO 'prometheus'@'%' IDENTIFIED BY 'prometheus';
GRANT SELECT, UPDATE, DELETE, DROP ON performance_schema.* TO 'prometheus'@'%';
GRANT ALL PRIVILEGES ON sbtest.* TO 'sysbench'@'%' IDENTIFIED BY 'sysbench';
