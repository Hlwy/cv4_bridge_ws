FROM ubuntu:18.04

# Set timezone and locale
RUN echo 'Etc/UTC' > /etc/timezone && ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime
RUN apt-get update && apt-get install -y tzdata locales && rm -rf /var/lib/apt/lists/*
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8

# Key packages
RUN apt update && apt upgrade -y && apt install -y bash-completion apt-utils \
     git wget curl cmake build-essential gnupg2 lsb-release \
     net-tools iputils-ping arp-scan \
     xorg-dev x11-apps x11-utils htop nmon \
     python3-pip python-pip uuid-dev hddtemp \
     libboost-all-dev libeigen3-dev libusb-1.0-0-dev libglfw3-dev

COPY .bashrc /root/.bashrc

# OpenCV packages
RUN apt update && apt install -y \
     libgtk2.0-dev libgtk-3-dev pkg-config \
     libavcodec-dev libavformat-dev libswscale-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
     python2.7-dev python3.6-dev python-dev python-numpy python3-numpy \
     libflann-dev libblas-dev libopenblas-dev liblapack-dev liblapacke-dev libtbb2 libtbb-dev libatlas-base-dev libceres-dev \
     libjpeg-dev libpng-dev libtiff-dev libx264-dev libdc1394-22-dev libxine2-dev \
     libavresample-dev libxvidcore-dev libavutil-dev \
     libv4l-dev v4l-utils qv4l2 v4l2ucp

# ROS Packages
RUN apt update && apt install -y libapr1-dev libaprutil1-dev \
     libassimp-dev libbullet-dev libbz2-dev liblz4-dev sbcl \
     libconsole-bridge-dev libcppunit-dev \
     libprotobuf-dev libprotoc-dev protobuf-compiler \
     python-empy python-matplotlib python-netifaces python-opengl python-psutil python-sip-dev python-wxtools \
     libsdl-image1.2-dev libsdl1.2-dev

RUN apt update && apt install -y libglew-dev libgl1-mesa-dev libglu1-mesa-dev libogre-1.9-dev \
     && apt install --no-install-recommends -y libasio-dev libyaml-cpp-dev \
     libtinyxml-dev libtinyxml2-dev libarmadillo-dev libpcl-dev libqt4-dev

RUN pip install numpy future

# Install ROS Melodic
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
# RUN apt update && apt install -y ros-melodic-desktop-full
RUN apt update && apt install -y ros-melodic-ros-base
RUN echo "source /opt/ros/melodic/setup.bash" >> /root/.bashrc
RUN wget http://packages.ros.org/ros.key -O - | apt-key add -
RUN apt update && apt install -y python-rosdep python-catkin-tools
RUN rosdep init && rosdep update

# For building cv4_bridge_ws
RUN apt update && apt install -y ros-melodic-angles ros-melodic-tf* ros-melodic-urdf \
     ros-melodic-resource-retriever ros-melodic-camera-info-manager ros-melodic-rqt-gui \
     ros-melodic-image-transport ros-melodic-rqt-gui-cpp ros-melodic-laser-geometry \
     ros-melodic-control-toolbox ros-melodic-polled-camera gazebo9 libgazebo9-dev \
     libgeographic-dev

## Install RtabMap
# RUN apt update && apt install -y ros-melodic-rtabmap ros-melodic-rtabmap-ros
## Install other ROS packages
# RUN apt update && apt install -y ros-melodic-mavros*

# Other useful packages
RUN apt update && apt install -y cmake-curses-gui nano i2c-tools iproute2
