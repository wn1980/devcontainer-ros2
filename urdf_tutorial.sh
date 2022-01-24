#!/usr/bin/env bash

set -e

sudo apt update && \
sudo apt install -y \
    ros-${ROS_DISTRO}-robot-state-publisher \
    ros-${ROS_DISTRO}-joint-state-publisher \
    && echo "DONE"

mkdir -p src

git clone https://github.com/benbongalon/ros2-urdf-tutorial.git && \
mv ros2-urdf-tutorial/urdf_tutorial src/ && \
rm -rf ros2-urdf-tutorial

colcon build --symlink-install --packages-select urdf_tutorial

source install/setup.bash
