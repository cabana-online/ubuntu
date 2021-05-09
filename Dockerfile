FROM ubuntu:16.04

# Metadata
LABEL base.image="ubuntu:focal"
LABEL description="An Ubuntu container to use whenever Alpine doesn't suffice for any reason."
LABEL maintainer="Alejandro Madrigal Leiva"
LABEL maintainer.email="me@alemadlei.tech"

USER root

ARG USER=cabana
ARG CABANA_USER_ID=1000
ARG CABANA_GROUP_ID=1000

ENV HOME /home/$USER

ARG DEBIAN_FRONTEND=noninteractive

RUN set -xe; \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y bash ca-certificates curl gzip tar unzip wget git perl software-properties-common && \
    apt-get clean && \
    apt-get autoclean;

# Creates work user.
RUN \
    addgroup --gid "${CABANA_GROUP_ID}" --quiet $USER; \
    adduser --gid "${CABANA_GROUP_ID}" --uid ${CABANA_USER_ID} --disabled-password --gecos "" $USER;

# Sets working directory.
WORKDIR $HOME

# Creates work folders.
RUN mkdir data tools && \
    chown -R $USER:$USER data && \
    chown -R $USER:$USER tools;

# Changes work user.
USER cabana
