FROM ubuntu:24.04

RUN apt update
RUN apt install -y net-tools
RUN apt install -y git curl build-essential libssl-dev zlib1g-dev
WORKDIR /
RUN git clone https://github.com/TelegramMessenger/MTProxy
WORKDIR /MTProxy
RUN sed -i 's/-D_FILE_OFFSET_BITS=64/-D_FILE_OFFSET_BITS=64 -fcommon/' Makefile
RUN make
WORKDIR /MTProxy/objs/bin
RUN curl -s https://core.telegram.org/getProxySecret -o proxy-secret
RUN curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf
# RUN apt install -y xxd
# RUN head -c 16 /dev/urandom | xxd -ps > client-secret
COPY start-mtproxy.sh /MTProxy/objs/bin/
RUN chmod +x start-mtproxy.sh

ENTRYPOINT ["/MTProxy/objs/bin/start-mtproxy.sh"]