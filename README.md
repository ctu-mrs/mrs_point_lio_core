# MRS Point-LIO Core

Metapackage containing submodules, launch files, config files, scripts, and other files necessary for running the MRS UAV system with Point-LIO state estimation.

## Submodules

| Repository                                                                                  |
|---------------------------------------------------------------------------------------------|
| [mrs_point_lio_estimator_plugin](https://github.com/ctu-mrs/mrs_point_lio_estimator_plugin) |
| [livox_ros_driver2](https://github.com/ctu-mrs/livox_ros_driver2)                           |
| [Point-LIO](https://github.com/ctu-mrs/Point-LIO)                                           |

## Installation
Install prerequisities for your `ROS_VERSION` and link to your `WORKSPACE`
```bash
WORKSPACE=$HOME/workspace
ROS_VERSION=ROS1 # (ROS1, ROS2)

cd $HOME/git && git clone git@github.com:ctu-mrs/mrs_point_lio_core.git
cd $HOME/git/mrs_point_lio_core/installation && ./install.sh
cd $WORKSPACE/src && ln -sf ~/git/mrs_point_lio_core .
```

And **manually** set the IP of your Livox MID360 in `livox_ros_driver2/config/MID360_config.json`. How to find the IP of the sensor is written [here](https://github.com/ctu-mrs/livox_ros_driver2/tree/master).

**Note 1:** do not forget to source your `WORKSPACE` in your `.*rc` file.

**Note 2:** this tutorial applies for ROS1 and Livox MID360 sensor - replace with your ROS and sensor as needed.

## Update and build
```bash
cd $WORKSPACE/src/mrs_point_lio_core
git pull && gitman update
catkin build
```

## Launch
Launch the driver and Point-LIO separately

```bash
roslaunch livox_ros_driver2 mid360.launch xfer_format:=1  # Livox MID360 driver
roslaunch point_lio mid360.launch rviz:=false             # Point-LIO
```

or use the prepared launch file for both at once
```bash
roslaunch mrs_point_lio_core point_lio_livox_mid360.launch
```

## TODOs

  * [ ] Automatize IP address deduction from env variables
  * [ ] Nodeletize and run under one nodelet manager:
    * [ ] livox_ros_driver2
    * [ ] Point-LIO
  * [ ] Make the custom msg format of livox_ros_driver2 visualizable in RViz
  * [ ] Lower the terminal spamming of the nodes and normalize their naming to improve clarity
