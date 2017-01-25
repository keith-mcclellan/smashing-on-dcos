#!/bin/bash
docker build -t keithmcclellan/smashing_on_dcos .
docker push keithmcclellan/smashing_on_dcos
dcos marathon app remove /smashing-dashboard
dcos marathon app add marathon.json
