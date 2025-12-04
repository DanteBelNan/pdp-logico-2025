FROM mcr.microsoft.com/devcontainers/base:debian-12

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    swi-prolog \
    swi-prolog-doc \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*