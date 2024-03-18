ARG SSH_AGENET_TAG=5.25.0-jdk21
FROM jenkins/ssh-agent:${SSH_AGENET_TAG}
ARG DOCKER_CE_CLI_VERSION=5:25.0.4-1~debian.12~bookworm
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        lsb-release \
    && rm -rf /var/lib/apt/lists/*
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
          signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
          https://download.docker.com/linux/debian \
          $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        docker-ce-cli=${DOCKER_CE_CLI_VERSION} \ 
    && rm -rf /var/lib/apt/lists/*
