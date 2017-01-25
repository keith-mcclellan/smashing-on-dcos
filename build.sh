#!/bin/bash
docker build -t keithmcclellan/smashing_on_dcos .
docker push keithmcclellan/smashing_on_dcos
dcos marathon app stop /smashing-dashboard
dcos marathon app start /smashing-dashboard
