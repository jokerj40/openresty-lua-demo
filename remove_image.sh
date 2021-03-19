#!/bin/bash

docker-compose down 2> /dev/null
docker rmi "$(docker images -q openresty-lua-demo_server)" 2> /dev/null