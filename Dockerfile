FROM hypriot/rpi-alpine-scratch:v3.4

ENV SS_VER 3.0.3 
ENV SS_URL https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_VER/shadowsocks-libev-$SS_VER.tar.gz 
#ENV SS_DIR shadowsocks-libev-$SS_VER
#ENV SS_DEP autoconf build-base libtool linux-headers pcre-dev asciidoc xmlto zlib-dev
RUN echo "http://dl-4.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.4/main" >> /etc/apk/repositories
RUN set -ex && \
    apk add --no-cache --virtual .build-deps \
                                autoconf \
                                build-base \
                                curl \
                                libev-dev \
                                libtool \
                                linux-headers \
                                udns-dev \
                                libsodium-dev \
                                mbedtls-dev \
                                pcre-dev \
                                tar \
                                udns-dev && \
    cd /tmp && \
    curl -sSL $SS_URL | tar xz --strip 1 && \
    ./configure --prefix=/usr --disable-documentation && \
    make install && \
    cd .. && \

    runDeps="$( \
        scanelf --needed --nobanner /usr/bin/ss-* \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
    )" && \
    apk add --no-cache --virtual .run-deps $runDeps && \
    apk del .build-deps && \
    rm -rf /tmp/* && \
	apk add --update bash

# build shadowsocks-libev
#RUN apk update && \
#    apk upgrade && \
#    apk add --update bash curl openssl-dev && \
#    curl -sSL "$SS_URL" | tar -xzv && \
#    apk del --purge curl
#
#WORKDIR "$SS_DIR"
#RUN apk add --update $SS_DEP && \
#    ./configure && \
#    make && \
#    make install && \
#    # clear build dependency
#    apk del --purge $SS_DEP && \
#    rm -rf /var/cache/apk/*
#
#WORKDIR /
#RUN rm -rf $SS_DIR
RUN mkdir -p /home/ssclient
ADD init ./
ENTRYPOINT ./init
