#!/bin/bash

sudo sysctl -w vm.max_map_count=262144
docker-compose -p dashboard-official -f docker-compose-canonical.yml -f docker-compose-eea-dashboard-official.yml up -d
