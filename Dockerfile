# Base image containing dependencies used in builder and final image
FROM swissgrc/azure-pipelines-openjdk:17.0.6.0 AS base


# Builder image
FROM base AS build

# Make sure to fail due to an error at any stage in shell pipes
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# renovate: datasource=repology depName=debian_11/curl versioning=loose
ENV CURL_VERSION=7.74.0-1.3+deb11u7

RUN apt-get update -y && \
  # Install necessary dependencies
  apt-get install -y --no-install-recommends curl=${CURL_VERSION} && \
  # Add NodeJS PPA
  curl -fsSL https://deb.nodesource.com/setup_16.x | bash -


# Final image
FROM base AS final

LABEL org.opencontainers.image.vendor="Swiss GRC AG"
LABEL org.opencontainers.image.authors="Swiss GRC AG <opensource@swissgrc.com>"
LABEL org.opencontainers.image.title="azure-pipelines-sonarscannercli"
LABEL org.opencontainers.image.documentation="https://github.com/swissgrc/docker-azure-pipelines-sonarscannercli"

# Make sure to fail due to an error at any stage in shell pipes
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /
COPY --from=build /usr/share/keyrings/ /usr/share/keyrings
COPY --from=build /etc/apt/sources.list.d/ /etc/apt/sources.list.d

# Install NodeJS

# renovate: datasource=github-tags depName=nodejs/node extractVersion=^v(?<version>.*)$
ENV NODE_VERSION=16.19.1

RUN apt-get update -y && \
  # Install NodeJs
  apt-get install -y --no-install-recommends nodejs=${NODE_VERSION}-deb-1nodesource1 && \
  # Clean up
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  # Smoke test
  node -v
