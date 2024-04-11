# syntax = edrevo/dockerfile-plus:0.1.0
FROM ubuntu:20.04 AS tipi-ubuntu-base
ENV TIPI_DISTRO_MODE=all

INCLUDE+ common/Dockerfile.apt-install-required
INCLUDE+ common/Dockerfile.apt-install-required-before-2204
INCLUDE+ common/Dockerfile.apt-install-required-by-customer

INCLUDE+ common/Dockerfile.remote-build-ssh-access

INCLUDE+ common/Dockerfile.tipi-non-root-user
INCLUDE+ common/Dockerfile.install-tipi