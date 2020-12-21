#!/bin/bash
xhost +local:root
NV_LIBS="/usr/lib/aarch64-linux-gnu /usr/local/cuda/lib64 /usr/lib/aarch64-linux-gnu/tegra \
          /usr/lib/aarch64-linux-gnu/gstreamer-1.0 /usr/lib/aarch64-linux-gnu/tegra-egl"
LD_PATH="/usr/lib/aarch64-linux-gnu /usr/lib/aarch64-linux-gnu/tegra \
          /usr/lib/aarch64-linux-gnu/gstreamer-1.0 /usr/lib/aarch64-linux-gnu/tegra-egl \
          /usr/local/cuda/lib64"
GPU_DEVICES="/dev/nvhost-ctrl /dev/nvhost-ctrl-gpu /dev/nvhost-prof-gpu \
          /dev/nvmap /dev/nvhost-gpu /dev/nvhost-as-gpu"

NV_DOCKER_ARGS="--net=host"

# set the required libraries as volumes on the docker container
build_docker_args() {
     LIB_ARGS=""
     for lib in $NV_LIBS; do
          LIB_ARGS="$LIB_ARGS -v $lib:$lib"
     done
     #set the required devices to be passed through to the container
     DEV_ARGS=""
     for dev in $GPU_DEVICES; do
          DEV_ARGS="$DEV_ARGS --device=$dev"
     done
     NV_DOCKER_ARGS="$NV_DOCKER_ARGS $LIB_ARGS $DEV_ARGS"
}
# build the LD_LIBRARY_PATH
build_env() {
     LD_LIBRARY_PATH=""
     for lib in $LD_PATH; do
          LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$lib"
     done
}

if [[ $# -ge 2 && $1 == "run" ]]; then
     echo "Running an nvidia docker image"
     build_docker_args
     build_env
     DOCKER_OPTS="-e LD_LIBRARY_PATH=$LD_LIBRARY_PATH $NV_DOCKER_ARGS ${@:2}"
     echo "docker run $DOCKER_OPTS"

     EXTRA_VOLUMES="-v /usr/src/linux-headers-$(uname -r)/include:/usr/src/linux-headers-$(uname -r)/include -v /usr/sbin/nvargus-daemon:/usr/sbin/nvargus-daemon:ro"
     docker run -it --privileged --cap-add=SYS_RAWIO $EXTRA_VOLUMES -v /dev:/dev -v $HOME/robot:/robot $DOCKER_OPTS /bin/bash
else
     docker $@
fi
