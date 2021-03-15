FROM alpine:3.13.2

LABEL maintainer="mjcramer@gmail.com"

RUN apk add --no-cache \
    apache2-utils \
    bash \
    bash-completion \
    bind-tools \
    bridge-utils \
    busybox-extras \
    ca-certificates \
    conntrack-tools \
    curl \
    dhcping \
    drill \
    ethtool \
    file \
    fping \
    grep \
    htop \
    httpie \
    iftop \
    iperf \
    iproute2 \
    ipset \
    iptables \
    iptraf-ng \
    iputils \
    ipvsadm \
    jq \
    mtr \
    net-snmp-tools \
    netcat-openbsd \
    nmap \
    nmap-nping \
    openssh-client \
    openssl \
    scapy \
    socat \
    strace \
    tcpdump \
    tcpdump \
    tcptraceroute \
    tree \
    tshark \
    util-linux \
    vim \
    wget

RUN rm -rf /var/cache/apk/*

ADD bashrc /root/.bashrc

ADD environment.sh /root/environment.sh
RUN chmod 755 /root/environment.sh

ENTRYPOINT [ "/bin/bash", "-c" ]

