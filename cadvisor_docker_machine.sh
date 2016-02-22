#!/bin/bash

docker-compose -f example_dbnode.yml stop cadvisor
docker-compose -f example_dbnode.yml rm -f cadvisor

docker-machine env
eval $(docker-machine env)
docker-machine ssh ${DOCKER_MACHINE_NAME} docker run -d -v /:/rootfs:ro -v /var/run:/var/run:rw -v /sys:/sys:ro -v /var/lib/docker/:/var/lib/docker:ro --net docker_dbnode -p 8080:8080 --name=db1_cadvisor google/cadvisor:latest
