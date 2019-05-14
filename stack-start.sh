#!/bin/bash

VERSION=${1:-6.3.1}

# Filebeat
cat filebeat/Dockerfile | \
 sed  -e 's/_STACK_VERSION_/'$VERSION'/g' \
 > filebeat/.Dockerfile.tmp

# Logstash
cat logstash/Dockerfile | \
 sed  -e 's/_STACK_VERSION_/'$VERSION'/g' \
 > logstash/.Dockerfile.tmp

# Elasticsearch
cat elasticsearch/Dockerfile | \
 sed  -e 's/_STACK_VERSION_/'$VERSION'/g' \
 > elasticsearch/.Dockerfile.tmp

# kibana
cat kibana/Dockerfile | \
 sed  -e 's/_STACK_VERSION_/'$VERSION'/g' \
 > kibana/.Dockerfile.tmp

docker-compose build
docker-compose up
