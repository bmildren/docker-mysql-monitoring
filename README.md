# MySQL Monitoring

MySQL monitoring example using docker-compose to orchestrate a monitoring solution using grafana, prometheus & influxdb, and an example db node using mysql, and the prometheus node_exporter and mysqld_exporter.  The prometheus config is manually configured in this example, although could be edited to use your preferred service discovery solution.  When editing the prometheus configuration (to add/remove nodes, etc), you can restart the prometheus container individually to pick up the config changes.

The example will work with docker-machine however you will have to forward the grafana port (3000) to your localhost (`ssh -L 3000:localhost:3000 docker@$(docker-machine ip)` [default boot2docker password == tcuser]).

### Example usage

Bring up monitor containers
```
docker-compose -f monitor.yml up -d
```

Bring up example db-node with node_exporter & mysqld_exporter
```
docker-compose -f dbnode.yml up -d
```

Restart individual service
```
docker-compose -f monitor.yml restart prometheus
```
```

View mysqld log 
```
docker-compose -f dbnode.yml logs mysqld
```
