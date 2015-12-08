#!/bin/sh

# Go.sh - Start a container from image.

# Map="-v /opt/local/data:/home/data"

Name="--name=sshscp"
Image="jhazelwo/sshscp"
Port=$(grep ^Port files/sshd_config|awk '{print $2}')
docker run $Name --net=host --expose=$Port $Map $Image

