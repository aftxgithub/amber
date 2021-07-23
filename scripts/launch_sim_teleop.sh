#!/usr/bin/env bash

# THIS SCRIPT LAUNCHES A KEYBOARD-CONTROLLED AMBER

# setup workspace folder
mkdir -p amber_ws/src
echo "Pulling project"
git clone https://github.com/thealamu/amber -b amber_sim_teleop amber_ws/src
cd amber_ws

# build
colcon build
source /usr/share/gazebo/setup.sh
source install/setup.bash

# launch simulation
world=$1
echo "Launching simulation with world: $world"
echo "Please start teleop_twist_key in another teminal"
ros2 launch amber_sim launch.py world:=$world
