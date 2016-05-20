#!/bin/bash

for i in {60..0}; do
    if curl -Is "http://admin:admin@grafana:3000" > /dev/null; then
        break
    fi

    echo 'Waiting for Grafana to startup...'
    sleep 3
done

if [ $i -eq 0 ] ; then
  echo "Grafana failed to startup" >&2
  exit 1
fi

curl http://admin:admin@grafana:3000/api/datasources -X POST -H 'Content-Type: application/json' \
  --data-binary '{"name":"Prometheus","type":"prometheus","url":"http://prometheus:9090","access":"proxy","isDefault":true}' 

curl http://admin:admin@grafana:3000/api/datasources -X POST -H 'Content-Type: application/json' \
  --data-binary '{"name":"InfluxDB (prometheus)","type":"influxdb","url":"http://influxdb:8086","access":"proxy","database":"prometheus","user":"root","password":"root","isDefault":false}'

curl http://admin:admin@grafana:3000/api/datasources -X POST -H 'Content-Type: application/json' \
  --data-binary '{"name":"InfluxDB (trending)","type":"influxdb","url":"http://influxdb:8086","access":"proxy","database":"trending","user":"root","password":"root","isDefault":false}'

sed -i 's/h=b.interval/h=i.replace(b.interval, a.scopedVars)/' /usr/share/grafana/public/app/plugins/datasource/prometheus/datasource.js

sed -i 's/,range_input/.replace(\/"{\/g,"\\"").replace(\/}"\/g,"\\""),range_input/; s/step_input:""/step_input:this.target.step/' /usr/share/grafana/public/app/plugins/datasource/prometheus/query_ctrl.js

