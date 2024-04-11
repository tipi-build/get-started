FROM ubuntu:20.04
ENV TIPI_DISTRO_MODE=all

ARG DEBIAN_FRONTEND=noninteractive # avoid tzdata asking for configuration
# Install needed tools
RUN apt-get -y update && apt-get install -y \
  sudo \
  unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tipi-build/cli/master/install/install_for_macos_linux.sh)"
RUN rm -rf /usr/local/share/.tipi/downloads/* \
	&& rm -rf /usr/local/share/.tipi/v*.d/* \
	&& rm -rf /usr/local/share/.tipi/v*.w/*

#INCLUDE+ common/Dockerfile.apt-install-required
#INCLUDE+ common/Dockerfile.apt-install-required-before-2204
#INCLUDE+ common/Dockerfile.apt-install-required-by-customer
#
#INCLUDE+ common/Dockerfile.remote-build-ssh-access
#
#INCLUDE+ common/Dockerfile.tipi-non-root-user
#INCLUDE+ common/Dockerfile.install-tipi