#!/bin/bash

repo=nvidia
base_name_docker_image=cuda
version=11.3.0-cudnn8-devel-ubuntu18.04
full_name_docker_image=$repo/$base_name_docker_image:$version
debug_string=_debug
full_name_docker_image_debug=$full_name_docker_image$debug_string



host_dir=$HOME
container_dir=$HOME

host_dir_synthetic_data=$HOME/Synthetic_Datasets
container_dir_synthetic_data=$HOME/Synthetic_Datasets

host_dir_data=$HOME/Repos/3D-Object-Detection-Models/VFF/data
container_dir_data=$HOME/Repos/3D-Object-Detection-Models/VFF/data




function run_docker_image_as_root () {
    name_suffix=$1
    docker run -ti --shm-size=2gb --gpus all --name "$base_name_docker_image_$version$name_suffix" -v $host_dir:$container_dir -v $host_dir_synthetic_data:$container_dir_synthetic_data -v $host_dir_data:$container_dir_data $full_name_docker_image /bin/bash
    docker stop "$base_name_docker_image_$version$name_suffix"
    docker rm "$base_name_docker_image_$version$name_suffix"
}

function run_docker_image_as_current_user () {
    name_suffix=$1
    docker run -ti --gpus all --user "$(id -u):$(id -g)" --name "$base_name_docker_image_$version$name_suffix" -v $host_dir:$container_dir -v $host_dir_synthetic_data:$container_dir_synthetic_data $full_name_docker_image /bin/bash
    docker stop "$base_name_docker_image_$version$name_suffix"
    docker rm "$base_name_docker_image_$version$name_suffix"
}

function run_docker_image_debug_as_root () {
    name_suffix=$1
    docker run -ti --gpus all --name "$full_name_docker_image_debug$version$name_suffix" -v $host_dir:$container_dir $full_name_docker_image_debug /bin/bash
    docker stop "$full_name_docker_image_debug$debug_string$version$name_suffix"
    docker rm "$full_name_docker_image_debug$version$name_suffix"
}

function run_docker_image_debug_as_current_user () {
    name_suffix=$1
    docker run -ti --gpus all --user "$(id -u):$(id -g)" --name "$full_name_docker_image_debug$version$name_suffix" -v $host_dir:$container_dir $full_name_docker_image_debug /bin/bash
    docker stop "$full_name_docker_image_debug$debug_string$version$name_suffix"
    docker rm "$full_name_docker_image_debug$version$name_suffix"
}




