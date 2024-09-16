# MRS Point-LIO Core

Metapackage containing submodules, launch files, config files, scripts, and other files necessary for running the MRS UAV system with Point-LIO state estimation.

## Submodules

| Repository                                                                                  |
|---------------------------------------------------------------------------------------------|
| [mrs_point_lio_estimator_plugin](https://github.com/ctu-mrs/mrs_point_lio_estimator_plugin) |
| [livox_ros_driver2](https://github.com/ctu-mrs/livox_ros_driver2)                           |
| [Point-LIO](https://github.com/ctu-mrs/Point-LIO)                                           |

## Installation

I) Install [`ctu-mrs/mrs_uav_modules`](https://github.com/ctu-mrs/mrs_uav_modules) (beware: will be used instead of `ros-noetic-mrs-uav-modules` package if installed)
```bash
MODULES_WORKSPACE=$HOME/modules_workspace

cd $HOME/git && git clone git@github.com:ctu-mrs/mrs_uav_modules.git
mkdir -p $MODULES_WORKSPACE/src && cd $MODULES_WORKSPACE/src && ln -sf $HOME/git/mrs_uav_modules .
cd mrs_uav_modules && git pull && gitman update

cd $MODULES_WORKSPACE && catkin init
catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
catkin config --extend /opt/ros/noetic
catkin build
```

II) Install [`ctu-mrs/mrs_point_lio_core`](git@github.com:ctu-mrs/mrs_point_lio_core.git)
```bash
WORKSPACE=$HOME/indair_workspace

cd $HOME/git && git clone git@github.com:ctu-mrs/mrs_point_lio_core.git
mkdir -p $WORKSPACE/src && cd $WORKSPACE/src && ln -sf $HOME/git/mrs_point_lio_core .
cd $HOME/git/mrs_point_lio_core/installation && ./install.sh

cd $WORKSPACE && catkin init
catkin config --profile reldeb --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
catkin config --extend $MODULES_WORKSPACE/devel # important to extend the modules workspace!
source $MODULES_WORKSPACE/devel/setup.sh && catkin build
```

And **manually** set the IP of your Livox MID360 in `livox_ros_driver2/config/MID360_config.json`. How to find the IP of the sensor is written [here](https://github.com/ctu-mrs/livox_ros_driver2/tree/master?tab=readme-ov-file#set-up-your-livox-sensor).

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
