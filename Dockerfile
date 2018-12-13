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
		python2-dev \
		libffi-dev \
		openssl-dev \
		build-base \
		autoconf \
		automake \
		vim \
		gcc \
		libc-dev \
		linux-headers \
	&& pip install --upgrade \
		pip \
	&& pip install \
		cffi==1.11.5 \
		shade \
	&& pip install \
		ansible==2.7.4 \
		ansible-lint==3.5.1 \
		awscli==1.16.74 \
		boto3==1.9.64 \
		boto==2.49.0 \
		docker==3.6.0 \
		dopy==0.3.7 \
		openstacksdk==0.20.0 \
		ansible-tower-cli==3.3.0 \
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

ADD endpoints_path.json /usr/lib/python2.7/site-packages/boto/endpoints.json

