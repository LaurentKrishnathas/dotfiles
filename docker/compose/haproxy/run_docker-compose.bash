#!/bin/bash
set -e
set -u

docker-compose build
docker-compose stop 
docker-compose rm -f
docker-compose up -d
docker-compose scale web=3
docker-compose logs -f