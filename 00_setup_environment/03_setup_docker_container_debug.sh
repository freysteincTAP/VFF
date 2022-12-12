#!/bin/bash

# include base script
. base.sh

echo "build docker image $full_name_docker_image_debug"
docker build --network=host --tag $full_name_docker_image_debug --target=debugger ./$base_name_docker_image/
