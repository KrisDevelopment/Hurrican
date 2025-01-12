#!/bin/bash

# Note: This script makes the assumption that you are using apt package manager and also have sudo access for resolving deps.

set -e

# DEPENDENCIES

if [ -z "$(which apt-get)" ]; then
    echo "This script is only for Debian-based systems with apt package manager."
    exit 1
fi

if [ -z "$(which sudo)" ]; then
    echo "No sudo command found. You need to have sudo access to install dependencies."
    echo "Do you want to skip installing dependencies? (y/n)"
    read skip
fi

if [ "$skip" = "y" ]; then
    echo "Skipping dependencies installation."
else
    sudo apt-get update
    sudo apt-get install build-essential g++ cmake ninja-build libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libopenmpt-dev libepoxy-dev
    sudo apt-get install libglm-dev
fi

# BUILD

mkdir Hurrican/build && cd Hurrican/build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .

# RUN

read -p "Do you want to run Hurrican now? (y/n)" run
if [ "$run" = "y" ]; then
    ./hurrican
fi