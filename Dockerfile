FROM alpine:3.10

LABEL maintainer="mjcramer@gmail.com"

RUN apk add --no-cache \
  ca-certificates \
  mtr \
  netcat-openbsd \
  wget \
  curl \
  bash \
  bash-completion \
  htop \
  tcpdump \
  nmap \
  iperf \
  jq \
  iftop \
  grep \
  openssh-client \
  tree

RUN rm -rf /var/cache/apk/*

ADD bashrc /root/.bashrc

ENTRYPOINT [ "/bin/bash", "-c" ]

