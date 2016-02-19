#!/bin/bash

for i in {60..0}; do
    if [ -d /var/lib/grafana/grafana-dashboards/dashboards ] ; then
        echo 'Grafana pre-script completed'
        break
    fi

    echo 'Waiting for Grafana pre-script to complete...'
    sleep 3
done

if [ $i -eq 0 ] ; then
  echo "Grafana pre-scripts failed to complete" >&2
  exit 1
fi

chown -R grafana:grafana /var/lib/grafana /var/log/grafana

exec gosu grafana /usr/sbin/grafana-server  \
  --homepath=/usr/share/grafana             \
  --config=/etc/grafana/grafana.ini         \
  cfg:default.paths.data=/var/lib/grafana   \
  cfg:default.paths.logs=/var/log/grafana
