#!/bin/bash

docker run --name "cabin" -p 3000:3000 -v $(pwd)/src:/app/src -it cabin
docker rm cabin
