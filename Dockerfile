# Alpine Linux 3.8
FROM	alpine:latest
LABEL	maintainer="Kawin Viriyaprasopsook <bouroo@gmail.com>"

ARG	timezone=Asia/Bangkok
ENV	TERM xterm

ENV	LANG en_US.UTF-8
ENV	LC_ALL en_US.UTF-8
ENV	TZ $timezone

# Add config repositories
RUN	echo 'https://mirror.kku.ac.th/alpine/latest-stable/main' > /etc/apk/repositories \
	&& echo 'https://mirror.kku.ac.th/alpine/latest-stable/community' >> /etc/apk/repositories \
	&& echo '@edge https://mirror.kku.ac.th/alpine/edge/main' >> /etc/apk/repositories \
	&& echo '@testing https://mirror.kku.ac.th/alpine/edge/testing' >> /etc/apk/repositories \
	&& mkdir /run/openrc \
	&& touch /run/openrc/softlevel

# Add basic package 
RUN	apk update && apk upgrade \
	&& apk add --no-cache \
	bash \
	bash-completion \
	curl \
	git \
	gnupg \
	htop \
	libressl \
	nano \
	openrc \
	pwgen \
	tzdata \
	wget

# Change timezone
RUN	echo $timezone > /etc/timezone \
	&& cp /usr/share/zoneinfo/$timezone /etc/localtime

# Change shell
RUN	sed -i "s|:ash|:bash|" /etc/passwd

# Clean file
RUN	rm -rf /var/cache/apk/*

COPY	./files /

CMD	["bash"]
