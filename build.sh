#!/bin/bash

# This script expects the following to be installed:
#   ~/st/stm32cubeide...

# Echo commands and exit on first failure
set -ex

# Some convenience variables.
# Change these if you'd like to use different versions.

# Note that applying an from update within the IDE will still
# keep the old version number in the path. Must reinstall the
# IDE to get the new path.
ide=stm32cubeide_1.6.1
# Don't version IDE destination, since version numbers in path
# don't necessarily reflect actual IDE version if updated locally.
# This causes incompatibilities with running CI locally.
ide_versionless=stm32cubeide

# default directory permissions don't allow re-writing into some directories
rm -rf $ide_versionless $fw

# Copy large file inputs locally.
# Unfortunately, we can't just symlink to these,
# since Docker won't follow symlinks.
cp -r /opt/st/$ide $ide_versionless

# Build the image
docker build --build-arg ide=$ide_versionless .
#
# Push to dockerhub by tagging the resulting image, e.g.:
#   docker tag <img> unspun/stm32cubeide1.6.1:F4_V1.25.1
# Then upload:
#   docker push unspun/stm32cubeide1.6.1:F4_V1.25.1
