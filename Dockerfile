# Alpine Linux 3.6
FROM alpine:latest
MAINTAINER kawin <kawinv@zercle.technology>

ARG	timezone=Asia/Bangkok
ENV	TERM xterm

ENV	LANG en_US.UTF-8
ENV	LC_ALL en_US.UTF-8
ENV	TZ $timezone

# Add public DNS && config repositories
RUN	echo 'https://mirror.kku.ac.th/alpine/latest-stable/main' > /etc/apk/repositories \
	&& echo '@community https://mirror.kku.ac.th/alpine/latest-stable/community' >> /etc/apk/repositories \
	&& echo '@edge https://mirror.kku.ac.th/alpine/edge/main' >> /etc/apk/repositories \
	&& echo '@testing https://mirror.kku.ac.th/alpine/edge/testing' >> /etc/apk/repositories \
	&& mkdir /run/openrc \
	&& touch /run/openrc/softlevel

# Add basic package 
RUN	apk update && apk upgrade \
	&& apk add --no-cache \
		openrc \
		libressl \
		wget \
		curl \
		git \
		nano \
		openssh \
		htop \
		bash \
		bash-completion \
		tzdata

# Change timezone
RUN	echo $timezone > /etc/timezone \
	&& cp /usr/share/zoneinfo/$timezone /etc/localtime

# Change shell
RUN	sed -i "s|:ash|:bash|" /etc/passwd

# Clean file
RUN	rm -rf /var/cache/apk/*

COPY	./files /
RUN	chmod +x /root/entrypoint.sh

ENTRYPOINT	["/root/entrypoint.sh"]
