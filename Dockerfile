FROM alpine:3.10
ADD ansible.cfg /etc/ansible/ansible.cfg
RUN apk update \ 
    && apk --no-cache --update add \
		git \
		openssl \
		openssh-client \
		python2 \
		py2-pip \
    && apk --update --virtual build-dependencies add \
		build-base \
		python2-dev \
		libffi-dev \
		openssl-dev \
		autoconf \
		automake \
    && pip install --upgrade pip \
    && pip install ansible==2.8.3 \
    && mkdir -p /tmp/download \
    && git clone https://github.com/bryanpkc/corkscrew.git /tmp/download/corkscrew \
    && cd /tmp/download/corkscrew && autoreconf --install && ./configure && make install \
    && apk del build-dependencies \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*
