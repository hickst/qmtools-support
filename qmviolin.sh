#!/bin/bash
#
# Shell script to run the QMViolin program from inside the QMTools Docker container.
# This script mounts the required directories and call the tool inside the container.
#
# echo "ARGS=$*"
IMG=hickst/qmtools

docker run -it --rm --name qmviolin  -v "${PWD}"/inputs:/qmtools/inputs:ro  -v "${PWD}"/fetched:/qmtools/fetched -v "${PWD}"/reports:/qmtools/reports --entrypoint qmviolin ${IMG} $@