#!/bin/bash

# include base script
. base.sh

echo "build docker image $full_name_docker_image"
docker build --network=host --tag $full_name_docker_image --target=base ./$base_name_docker_image/
