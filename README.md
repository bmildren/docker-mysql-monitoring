# MySQL Monitoring

Requires Docker 1.10+

MySQL monitoring example using docker-compose to orchestrate a monitoring solution using grafana, prometheus & influxdb, and an example db node using mysql, and the prometheus node_exporter and mysqld_exporter.  The prometheus config is manually configured in this example, although could be edited to use your preferred service discovery solution.  The prometheus configuration file can be found here: `./prometheus/config/prometheus.yml`, the config is imported into the container on startup.  When editing the prometheus configuration (to add/remove nodes, etc), you can restart the prometheus container individually to pick up the config changes.

The example will work with docker-machine however you will have to forward the grafana port (3000) to your localhost e.g. `ssh -L 3000:localhost:3000 docker@$(docker-machine ip)` (_default boot2docker password == tcuser_).

cadvisor needs to mount filesystems from the host running the docker containers, the combination of docker-compose and docker-machine won't allow this, however a simple bash script is supplied `cadvisor_docker_machine.sh` which will stop the cadvisor container created by docker-compose and run one manually on the supplied docker-machine.

### Installation
* If you don't have it installed already, install docker-compose (https://docs.docker.com/compose/install/)
* run: `docker-compose -f monitor.yml up -d`
* To install an example db node with associated collectors `docker-compose -f example_dbnode.yml up -d`
* To install only the collecters using docker (not required for the example dbnode) `docker-compose -f collecters.yml up -d`
* If you're running docker-machine use `cadvisor_docker_machine.sh` to relaunch the cadvisor container remotely

If you want to monitor other hosts edit the prometheus config file `./prometheus/config/prometheus.yml` add additional targets or your service discovery of choice, and restart prometheus `docker-compose -f monitor.yml restart prometheus`

### Default ports
* Grafana: 3000
* Prometheus: 9090
* InfluxDB: 8083 8086
* MySQL: 3306
* Prometheus Node Exporter: 9100
* Prometheus MySQL Exporter: 9104
* cAdvisor: 8080

### Example usage

Bring up monitor containers
```
docker-compose -f monitor.yml up -d
```

Bring up example db-node with node_exporter & mysqld_exporter
```
docker-compose -f example_dbnode.yml up -d
```

Restart individual service
```
docker-compose -f monitor.yml restart prometheus
```

View mysqld log 
```
docker-compose -f example_dbnode.yml logs mysqld
```
