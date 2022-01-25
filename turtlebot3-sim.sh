#!/usr/bin/env bash

set -e

sudo apt update && \
sudo apt install -y \
    ros-${ROS_DISTRO}-slam-toolbox \
    ros-${ROS_DISTRO}-nav2-bringup \
    ros-${ROS_DISTRO}-turtlebot3-simulations \
    ros-${ROS_DISTRO}-turtlebot3-teleop \
    ros-${ROS_DISTRO}-turtlebot3-navigation2 \
    && echo "DONE"

echo "export TURTLEBOT3_MODEL=waffle_pi" >> ~/.bashrc
