# amber
Amber Dynamics' Autonomous Worker Robot

## Launch
This repository provides two options for starting the simulation:
- Launch in a workspace without ROS2 installed using the [Launch Script](#launch-script) (Ubuntu only)
- Launch in a workspace with an existing ROS2 installation using [ROS2 Launch](#ros2-launch)

### Launch Script
The launch script is suitable for a bare ubuntu installation (i.e. one without ros or gazebo). The script automatically installs ROS2 and Gazebo as well as the required build dependencies.
Execute these shell commands to launch the simulation using the launch bash script:

#### Download the launch script
```shell
wget https://raw.githubusercontent.com/thealamu/amber/main/scripts/launch_sim_teleop.sh
chmod +x launch_sim_teleop.sh
```
#### Run the script
This command starts the simulation in an empty world:
```shell
./launch_sim_teleop.sh empty.world
```
To start the simulation in a world with moving obstacles:
```shell
./launch_sim_teleop.sh dynamic_obstacles.world
```

### ROS2 Launch
If you have an existing ros2 installation, follow these steps to launch the simulation:

#### Clone the repository
```shell
mkdir -p amber_ws/src
git clone https://github.com/thealamu/amber amber_ws/src
cd amber_ws
```

#### Build the packages
```shell
colcon build
source /usr/share/gazebo/setup.sh
source ./install/setup.bash
```

#### Start the simulation
You can start in an empty world:
```shell
ros2 launch amber_sim launch.py world:=empty.world
```
or a world with moving obstacles:
```shell
ros2 launch amber_sim launch.py world:=dynamic_obstacles.world
```

## Teleoperation
To get the robot moving, open another terminal and start a teleop key node using the following shell command:
```shell
ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args --remap /cmd_vel:=/amber_sim/cmd_vel
```
The robot should respond to your teleop keys.
