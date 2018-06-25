set -e
set -u

docker-compose stop
docker-compose rm -f
docker-compose up -d 
docker-compose logs -f
