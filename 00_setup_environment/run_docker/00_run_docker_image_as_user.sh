#!/bin/bash


# include base script
. ../00_setup_environment/base.sh

host_dir_kitti=$HOME/Kitti
container_dir_kitti=/Kitti

run_docker_image_as_user "_$number_container"
