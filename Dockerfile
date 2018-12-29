FROM ubuntu:16.04

ENV LANG C.UTF-8

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils software-properties-common nodejs npm git make

RUN ln -s /usr/bin/nodejs /usr/bin/node

# ignore gpg key exit status
RUN add-apt-repository -y ppa:jonathonf/calibre; exit 0

RUN apt-get update && apt-get install -y calibre 


# Simple root password in case we want to customize the container
RUN echo "root:root" | chpasswd

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /app/gitbook && \
    mkdir -p /etc/sudoers.d && \
    echo "dev:x:${uid}:${gid}:Dev,,,:/app:/bin/bash" >> /etc/passwd && \
    echo "dev:x:${uid}:" >> /etc/group && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev && \
    chmod 0440 /etc/sudoers.d/dev && \
    chown ${uid}:${gid} -R /app

WORKDIR /app/gitbook

USER dev

EXPOSE 4000
