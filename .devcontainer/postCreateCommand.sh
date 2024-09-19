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
echo 'eval "$(register-python-argcomplete ros2)"' >> ~/.bashrc
echo 'eval "$(register-python-argcomplete colcon)"' >> ~/.bashrc
echo 'eval "$(task --completion bash)"' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME/.cargo/bin' >> ~/.bashrc

# Install additional ROS 2 packages
sudo apt-get -y install ros-${ROS_DISTRO}-navigation2
sudo apt-get -y install ros-${ROS_DISTRO}-nav2-bringup
sudo apt-get -y install ros-${ROS_DISTRO}-turtlebot3*
