#!/bin/bash

# Install oh-my-bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

# Install better tools
export PATH=$PATH:$HOME/.cargo/bin
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

cargo binstall -y eza fd-find ripgrep bat
echo 'alias ls="eza"' >> ~/.bashrc
sudo apt-get update && sudo apt-get install -y tmux
ln -s $PWD/.devcontainer/tmux.conf ~/.tmux.conf

sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/.local/bin

pushd /tmp
wget https://github.com/junegunn/fzf/releases/download/0.51.0/fzf-0.51.0-linux_amd64.tar.gz
tar xf fzf-0.51.0-linux_amd64.tar.gz
sudo mv fzf /usr/local/bin/
rm fzf-0.51.0-linux_amd64.tar.gz
popd

# Set bashrc
echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
echo 'eval "$(register-python-argcomplete3 ros2)"' >> ~/.bashrc
echo 'eval "$(register-python-argcomplete3 colcon)"' >> ~/.bashrc
echo 'eval "$(task --completion bash)"' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME/.cargo/bin' >> ~/.bashrc

cat <<EOF >> ~/.bashrc
# for classic gazebo
stat /usr/share/gazebo/setup.sh &> /dev/null
if [ $? -eq 0 ]; then
    source /usr/share/gazebo/setup.sh
fi
EOF

echo 'export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp' >> ~/.bashrc

# Install additional ROS 2 packages
sudo apt-get -y install \
    ros-${ROS_DISTRO}-navigation2 \
    ros-${ROS_DISTRO}-nav2-bringup \
    ros-${ROS_DISTRO}-turtlebot3* \
    ros-${ROS_DISTRO}-teleop-twist-keyboard \
    ros-${ROS_DISTRO}-rqt-graph \
    ros-${ROS_DISTRO}-rqt-tf-tree \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
    python3-pandas
    # ignition-fortress \
    # ros-${ROS_DISTRO}-ros-ign
