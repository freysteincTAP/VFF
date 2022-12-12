#!/bin/bash

# include base script
. ../base.sh


echo "Which container shall be used?"
echo "The following containers are already in use:"
result_docker_command=$(docker ps --format {{.Names}})
if [ -z "$result_docker_command" ]
then
echo "there are currently no containers in use!"
else
echo $result_docker_command
fi

echo "Please enter the number of the container you want to use (1-X):"
number_container=""
read number_container

run_docker_image_as_root "_$number_container"
