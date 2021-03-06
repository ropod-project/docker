FROM git.ropod.org:4567/ropod/docker/ropod-base:kinetic

WORKDIR /ropod_msgs_ws
RUN catkin init \
    && catkin config --install --install-space /opt/ropod/ros/ \
    && catkin config --cmake-args -DPYTHON_VERSION=3.5 \
    && catkin config --extend /opt/ros/kinetic/

WORKDIR src
RUN git clone https://github.com/ropod-project/ropod_ros_msgs.git

WORKDIR /ropod_msgs_ws
RUN sh /opt/ros/kinetic/setup.sh && \
    apt update -qq && \
    rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y && \
    catkin build

COPY ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint"]
