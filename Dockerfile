FROM alpine:3.9
RUN	apk update
RUN apk --no-cache --update add \
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
		zip
RUN apk --update add --virtual \
		build-dependencies \
		python2-dev \
		libffi-dev \
		openssl-dev \
		build-base \
		autoconf \
		automake
RUN pip install --upgrade pip
RUN pip install \
		ansible==2.8.0 \
		ansible-lint==4.1.0 \
		docker==3.7.2 \
		dopy==0.3.7
RUN mkdir -p /tmp/download
RUN curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.06.1-ce.tgz | tar -xz -C /tmp/download
RUN mv /tmp/download/docker/docker /usr/local/bin/
RUN git clone https://github.com/bryanpkc/corkscrew.git /tmp/download/corkscrew
RUN cd /tmp/download/corkscrew && autoreconf --install && ./configure && make install
RUN apk del build-dependencies
RUN rm -rf /tmp/*
RUN rm -rf /var/cache/apk/*
