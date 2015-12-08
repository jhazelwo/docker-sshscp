#!/bin/sh

# Go.sh - Start a container from image.

# Paths to map in the container. (optional)
#Map="-v /opt/local/data:/home/data"

# Name of the running container. (optional)
Name="--name=sshscp"

# Image we base the container on.
Image="jhazelwo/sshscp"

# Port this SSHD is listening on.
Port=$(grep ^Port files/sshd_config|awk '{print $2}')

# http://docs.docker.com/engine/reference/run/#network-settings
Net="--net=host"

#
docker run $Name $Net --expose=$Port $Map $Image

