FROM ros:kinetic-ros-core

RUN apt update -qq \
    && apt upgrade -y \
    && apt install -y python-catkin-tools \
    python-wstools \
    python-catkin-lint \
    python3-pip \
    vim \
    && rm -rf /var/lib/apt/lists/* \
