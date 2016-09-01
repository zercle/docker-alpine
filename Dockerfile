FROM alpine:latest
MAINTAINER bouroo <bouroo@gmail.com>

ARG	timezone=Asia/Bangkok
ENV	TIMEZONE $timezone
ENV	TERM xterm

# Change root password
RUN	echo "root:P@ssw0rd" | chpasswd

# Add public DNS && config repositories
RUN	echo 'nameserver 64.6.64.6' > /etc/resolv.conf && \
	echo 'nameserver 8.8.8.8' >> /etc/resolv.conf && \
	echo 'http://dl-cdn.alpinelinux.org/alpine/latest-stable/main' > /etc/apk/repositories && \
	echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
	echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
	echo '@community http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

# Add basic package 
RUN	apk update && \
	apk add --no-cache \
		openrc \
		openssl \
		wget \
		curl \
		git \
		nano \
		openssh \
		htop \
		zsh \
		bash \
		tzdata && \
	rc-update add sshd

# Change timezone
RUN	echo $timezone > /etc/timezone && \
	cp /usr/share/zoneinfo/$timezone /etc/localtime

# Clean file
RUN	rm -rf /var/cache/apk/*

COPY	./files /
RUN	chmod +x /root/entrypoint.sh

EXPOSE	22

ENTRYPOINT	["/root/entrypoint.sh"]
