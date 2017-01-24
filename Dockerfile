FROM hypriot/rpi-alpine-scratch 

ENV SS_VER 2.5.6
ENV SS_URL https://github.com/shadowsocks/shadowsocks-libev/archive/v$SS_VER.tar.gz
ENV SS_DIR shadowsocks-libev-$SS_VER
ENV SS_DEP autoconf build-base libtool linux-headers pcre-dev asciidoc xmlto zlib-dev

# build shadowsocks-libev
RUN apk update && \
    apk upgrade && \
    apk add --update bash curl openssl-dev && \
    curl -sSL "$SS_URL" | tar -xzv && \
    apk del --purge curl

WORKDIR "$SS_DIR"
RUN apk add --update $SS_DEP && \
    ./configure && \
    make && \
    make install && \
    # clear build dependency
    apk del --purge $SS_DEP && \
    rm -rf /var/cache/apk/*

WORKDIR /
RUN rm -rf $SS_DIR

ADD init ./
ENTRYPOINT ./init
