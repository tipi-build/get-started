# syntax = edrevo/dockerfile-plus:0.1.0
FROM ubuntu:20.04
ENV TIPI_DISTRO_MODE=all

ARG DEBIAN_FRONTEND=noninteractive # avoid tzdata asking for configuration
# Install needed tools
RUN apt-get -y update && apt-get install -y \
  openssh-server \
  sudo \
  curl \
  unzip \
  build-essential \
  git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

#INCLUDE+ common/Dockerfile.apt-install-required
#INCLUDE+ common/Dockerfile.apt-install-required-before-2204
#INCLUDE+ common/Dockerfile.apt-install-required-by-customer
#
INCLUDE+ common/Dockerfile.remote-build-ssh-access
#
INCLUDE+ common/Dockerfile.tipi-non-root-user

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tipi-build/cli/master/install/install_for_macos_linux.sh)"
RUN mkdir main && echo "int main(){}" >> ./main/main.cpp \
	&& /usr/local/bin/tipi --dont-upgrade -v -t linux ./main \
	&& rm -rf ./main \
  && rm -rf /usr/local/share/.tipi/downloads/* \
	&& rm -rf /usr/local/share/.tipi/v*.d/* \
	&& rm -rf /usr/local/share/.tipi/v*.w/*
#INCLUDE+ common/Dockerfile.install-tipi