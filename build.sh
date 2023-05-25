#!/bin/sh
VERSION="1.1.0"
# build simples
#docker build -t vertigo/vkpr:$VERSION .
# build multiplataforma
# precisa antes iniciar contexto
# docker buildx create --name mybuilder --use --bootstrap
docker buildx build --push --platform linux/arm64/v8,linux/amd64 \
  --tag vertigo/vkpr:$VERSION .
