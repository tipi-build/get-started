ARG UBUNTU_20_04="ubuntu@sha256:c664f8f86ed5a386b0a340d981b8f81714e21a8b9c73f658c4bea56aa179d54a"
FROM ${UBUNTU_20_04}

ENV TIPI_DISTRO_MODE=all
ENV TIPI_INSTALL_LEGACY_PACKAGES=ON
COPY --from=tipi /tipi-linux-x86_64.zip .
ENV TIPI_INSTALL_SOURCE=file:///tipi-linux-x86_64.zip

ARG DEBIAN_FRONTEND=noninteractive # avoid tzdata asking for configuration
# Install tipi and cmake-re

RUN apt update -y && apt install -y curl gettext
RUN curl -fsSL https://raw.githubusercontent.com/tipi-build/cli/4d3116738b96de360fb5cd7653472b041bca3de1/install/container/ubuntu.sh -o ubuntu.sh && /bin/bash ubuntu.sh
EXPOSE 22