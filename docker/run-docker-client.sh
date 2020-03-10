#!/bin/bash
# 640 480 Beautiful
#xvfb-run --auto-servernum --server-args="-screen 0 624x324x24" \
#    unity_vol/executable_unix/exec_linux.x86_64 -batchmode \
#    -screen-width=$1 -screen-height=$2 -screen-quality=$3 \
#    -http-port=8080

#docker run --mount type=bind,source="$(pwd)"/unity_vol,target=/unity_vol/ \
# 			 -p 8080:8080 \
# 			 -ti virtualhome-unity:latest


#!/usr/bin/env bash

xhost +local:root

CONTAINERNAME=virtualhome-unity

declare -a VSHARES
VSHARES[0]="--volume=/run/user/${USER_UID}/pulse/:/run/user/1000/pulse/"
VSHARES[1]="--volume=/tmp/.X11-unix/:/tmp/.X11-unix:rw"

USER_UID=$(id -u)
test -z "$USER" && USER=$(id -un)

test "$USER_UID" -eq 0 && USER_UID=1000

if [ -z "$XAUTHORITY" ]; then
    echo "No XAUTHORITY environment variable found. Please define one so we know which file to copy into container."
    exit 2
fi

test -z "$DISPLAY" && DISPLAY=:0

# Port 8080 for Unity
# Port 8888 for Jupyter
docker run -t -i \
  --name $CONTAINERNAME \
  "${VSHARES[@]}" \
  -v "$(pwd)/..:/virtualhome/" \
  -e DISPLAY=$DISPLAY \
  --network=host \
  --ipc=host \
  --privileged \
  --gpus all \
  -p 8080:8080 \
  -p 8888:8888 \
  $CONTAINERNAME:latest

xhost -local:root
