# Create this image by running:
# ./build.sh

# The above script expects the host to have the following installed:
#   ~/st/stm32cubeide...

FROM ubuntu:20.04

# Install mainstream applications
RUN apt update && apt install -y \
    python3 \
    clang-format \
    cpputest \
    make \
    g++ \
    lcov

#variables passed during build
ARG ide
# e.g. stm32cubeide_1.4.0

# Convenience variables
ARG stm_repo=/usr/local/share/stm_repo

# Copy ide
RUN mkdir -p /opt/st
COPY $ide /opt/st/$ide

# Backwards compatibility for linux-only FW path.
# Will eventually deprecate.
#RUN ln -s $stm_repo /usr/share/stm_repo
