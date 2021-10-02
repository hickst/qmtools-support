#!/bin/bash
#
# Shell script to run the QMFetcher program from inside the QMTools Docker container.
# This script mounts the required directories and call the tool inside the container.
#
# echo "ARGS=$*"
IMG=hickst/qmtools

docker run -it --rm --name qmfetcher  -v "${PWD}"/inputs:/qmtools/inputs:ro  -v "${PWD}"/fetched:/qmtools/fetched -v "${PWD}"/queries:/qmtools/queries --entrypoint qmfetcher ${IMG} $@