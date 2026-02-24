# Start from ROS 2 Humble Desktop (Ubuntu 22.04)
ARG ROS_DISTRO=humble
FROM osrf/ros:${ROS_DISTRO}-desktop

# Avoid timezone prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install System & Build Tools
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    cmake \
    python3-pip \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 2. Install Project-Specific ROS 2 Dependencies (Phase 1, 4, & 9)
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-vision-msgs \
    ros-${ROS_DISTRO}-robot-localization \
    ros-${ROS_DISTRO}-message-filters \
    ros-${ROS_DISTRO}-tf-transformations \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-rviz2 \
    ros-${ROS_DISTRO}-foxglove-bridge \
    && rm -rf /var/lib/apt/lists/*

# 3. Install Simulation Tools (Phase 2 - VRX/Gazebo)
# (Note: VRX currently targets Gazebo Classic for Humble, but check VRX repo for updates)
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-gazebo-ros-pkgs \
    && rm -rf /var/lib/apt/lists/*

# 4. Install Perception Stack (Phase 5 & 7)
# YOLOv8/v11, SAHI, ByteTrack, OpenCV
RUN pip3 install --no-cache-dir \
    ultralytics \
    sahi \
    opencv-python-headless \
    lapx \
    numpy \
    scipy \
    transforms3d

# 5. Setup Workspace Environment
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /etc/bash.bashrc
ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp

# 6. Add non-root user (Standard Devcontainer Practice)
ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /workspaces/autonomy_stack
