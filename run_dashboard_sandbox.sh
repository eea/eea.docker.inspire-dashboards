#!/bin/bash

sudo sysctl -w vm.max_map_count=262144
docker-compose -p dashboard-sandbox -f docker-compose-canonical.yml -f docker-compose-eea-dashboard-sandbox.yml up -d
