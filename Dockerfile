FROM alpine:3.10
ADD ansible.cfg /etc/ansible/ansible.cfg
RUN apk update \ 
    && apk --no-cache --update add \
		git \
		openssl \
		openssh-client \
		python3 \
		rsync \
		build-base \
		python3-dev \
		libffi-dev \
    && apk --update --virtual build-dependencies add \
		openssl-dev \
		autoconf \
		automake \
    && pip3 install --upgrade pip \
    && python3 -m venv /opt/virtualenvs/default \
    && source /opt/virtualenvs/default/bin/activate \
    && pip3 install ansible==2.9.4 \
    && deactivate \
    && mkdir -p /tmp/download \
    && git clone https://github.com/bryanpkc/corkscrew.git /tmp/download/corkscrew \
    && cd /tmp/download/corkscrew && autoreconf --install && ./configure && make install \
    && apk del build-dependencies \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*
