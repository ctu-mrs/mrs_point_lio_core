#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

## | --------------- Preparation for ROS switch --------------- |
# ROS_DISTRO="ROS1"
# if [[ "$#" -eq 1 ]]; then
#   ROS_DISTRO="$1"
# elif [[ "$#" -gt 1 ]]; then
#   echo "Usage: ./install.sh [ ROS1 (default) | ROS2 ]"
#   exit -1
# fi

# if [[ "$ROS_DISTRO" != "ROS1" && "$ROS_DISTRO" != "ROS2" ]]; then
#   echo "Usage: ./install.sh [ ROS1 (default) | ROS2 ]"
#   exit -1
# fi

# echo "Installing for ROS version: $ROS_DISTRO"

## | ----------------- Install prerequisities ----------------- |
sudo apt-get install\
  ros-noetic-pcl-conversions\
  libeigen3-dev
sudo pip install gitman

cd $SCRIPT_PATH/..
git pull
gitman update

# Install Livox SDK2
bash $SCRIPT_PATH/../ros_packages/livox_ros_driver2/installation/install.sh ROS1
