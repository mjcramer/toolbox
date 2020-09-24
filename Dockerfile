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

ADD environment.sh /root/environment.sh
RUN chmod 755 /root/environment.sh

ENTRYPOINT [ "/bin/bash", "-c" ]

