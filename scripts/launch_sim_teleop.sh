#!/usr/bin/env bash

# THIS SCRIPT LAUNCHES A KEYBOARD-CONTROLLED AMBER

# Setup Dependencies

if [[ -z "$(which ros2)" ]]; then
	echo "ROS2 installation not found, trying to install"

	# add ROS2 apt repository
	sudo apt update && sudo apt install -y curl gnupg2 lsb-release
	sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
	sudo apt update

	# install ros-base
	sudo apt install -y ros-foxy-ros-base
	echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
	source ~/.bashrc

	sudo apt install ros-foxy-gazebo-ros-pkgs

	echo "ROS2 installation successful"
fi

if [[ -z "$(which gazebo)" ]]; then
	echo "Gazebo installation not found, trying to install"
	curl -sSL http://get.gazebosim.org | sh
	echo "Gazebo installation successful"
fi

# install colcon
if [[ -z "$(which colcon)" ]]; then
    echo "Installing colcon"
    curl -s https://packagecloud.io/install/repositories/dirk-thomas/colcon/script.deb.sh | sudo bash
    sudo apt install python3-colcon-common-extensions
fi

# install git
sudo apt install -y git

# Launch Simulation

# setup workspace folder
mkdir -p amber_ws/src
echo "Pulling project"
git clone https://github.com/thealamu/amber -b amber_sim_teleop amber_ws/src
cd amber_ws

mkdir -p amber_ws/src/teleop_twist_keyboard
echo "Pulling teleop"
git clone https://github.com/ros2/teleop_twist_keyboard amber_ws/src/teleop_twist_keyboard

# build
colcon build
source /usr/share/gazebo/setup.sh
source install/setup.bash

# launch
world=$1
echo "Launching simulation with world: $world"
echo "Please start teleop_twist_key in another teminal"
ros2 launch amber_sim launch.py world:=$world
