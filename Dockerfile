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
		python-dev \
		libffi-dev \
		openssl-dev \
		build-base \
		autoconf \
		automake \
		vim \
	&& pip install --upgrade \
		pip \
		cffi \
		botocore \
	&& pip install \
		ansible==2.5.0 \
		ansible-lint==3.4.23 \
		awscli==1.15.59 \
		boto==2.49.0 \
		boto3==1.7.58 \
		docker==3.4.1 \
		dopy==0.3.7 \
    && mkdir -p /tmp/download \
    && curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz | tar -xz -C /tmp/download \
    && mv /tmp/download/docker/docker /usr/local/bin/ \
    && cd /tmp/download \
	&& git clone https://github.com/bryanpkc/corkscrew.git \
	&& cd corkscrew \
	&& autoreconf --install && ./configure && make install \
	&& apk del build-dependencies \
	&& rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/*
