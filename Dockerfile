FROM ubuntu:latest
LABEL maintainer="Ganesh Gunasegaran <me@itsgg.com>"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y jq wget curl unzip git python build-essential libxml2-dev libxslt-dev \
                    ca-certificates dirmngr gpg-agent gpg \
                    libssl-dev automake autoconf libncurses5-dev libncursesw5-dev \
                    libreadline-dev libmariadb-dev mariadb-client \
                    zlib1g-dev libbz2-dev llvm libsqlite3-dev  \
                    xz-utils tk-dev libffi-dev liblzma-dev python-openssl \
                    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

RUN useradd -ms $(which bash) asdf

USER asdf

ENV PATH /home/asdf/.asdf/bin:/home/asdf/.asdf/shims:$PATH

RUN /bin/bash -c "git clone https://github.com/asdf-vm/asdf.git /home/asdf/.asdf && \
                  asdf plugin-add erlang && \
                  asdf plugin-add elixir && \
                  asdf plugin-add ruby && \
                  asdf plugin-add python && \
                  asdf plugin-add nodejs && \
                  asdf plugin-add java && \
                  rm -rf  /tmp/*"

RUN /bin/bash -c /home/asdf/.asdf/plugins/nodejs/bin/import-release-team-keyring

WORKDIR /home/asdf/

COPY . .
