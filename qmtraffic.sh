#!/bin/bash
#
# Shell script to run the QMTraffic program from inside the QMTools Docker container.
# This script mounts the required directories and call the tool inside the container.
#
# echo "ARGS=$*"
IMG=hickst/qmtools

docker run -it --rm --name qmtraffic  -v "${PWD}"/inputs:/qmtools/inputs:ro  -v "${PWD}"/reports:/qmtools/reports --entrypoint qmtraffic ${IMG} $@