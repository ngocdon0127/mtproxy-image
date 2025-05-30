#!/bin/bash
CONTAINER_IP=$(ifconfig | grep -P "inet 172[\.\d]+" -o | grep -o -P "[\.\d]+")
CLIENT_SECRET=$(cat ./client-secret)
echo "Container IP: $CONTAINER_IP"
echo "Client secret: $CLIENT_SECRET"

: "${PROXY_HOST:=127.0.0.1}"
: "${PROXY_TAG:=123}"
echo "Proxy Host: $PROXY_HOST"
echo "Proxy Tag: $PROXY_TAG"

: "${NO_OF_WORKERS:=1}"
echo "Number of Workers: $NO_OF_WORKERS"
sleep 3s

./mtproto-proxy -u nobody -p 8888 -H 443 -S $CLIENT_SECRET --aes-pwd proxy-secret proxy-multi.conf -M "$NO_OF_WORKERS" --nat-info "$CONTAINER_IP:$PROXY_HOST" -P "$PROXY_TAG"