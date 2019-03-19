FROM alpine:3.8

RUN	apk update && \
	apk --no-cache --update add \
		ca-certificates \
		curl \
		git \
		openssl \
		openssh-client \
		p7zip \
		python \
		py-lxml \
		py-pip \
		rsync \
		sshpass \
		zip \
    && apk --update add --virtual \
		build-dependencies \
		python2-dev \
		libffi-dev \
		openssl-dev \
		build-base \
		autoconf \
		automake \
	&& pip install --upgrade \
		pip \
	&& pip install \
		ansible==2.7.4 \
		ansible-lint==3.5.1 \
		docker==3.6.0 \
		d1.1.2opy==0.3.7 \
		jsondiff==1.1.2 \
    && mkdir -p /tmp/download \
    && curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.06.1-ce.tgz | tar -xz -C /tmp/download \
    && mv /tmp/download/docker/docker /usr/local/bin/ \
    && cd /tmp/download \
	&& git clone https://github.com/bryanpkc/corkscrew.git \
	&& cd corkscrew \
	&& autoreconf --install && ./configure && make install \
	&& apk del build-dependencies \
	&& rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/*

ADD ./docker_stack.py /usr/share/ansible/plugins/modules/