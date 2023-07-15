#!/bin/bash -e

function cleanup {
  echo "Cleanup on exit"
  sudo docker compose -f docker-compose.yml -f docker-compose-developement.yml down
}

#check if dns container is running

if [ "$(sudo docker ps -q -f name=dns)" ]; then
  trap cleanup EXIT

  sudo DOCKERDNS=$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dns) docker compose -f docker-compose.yml -f docker-compose-developement.yml up
else
	echo "DNS container is not running"
fi
