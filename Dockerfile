FROM alpine:3.18
#ARG VKPR_VERSION=1.1.9
#-----------------------------------------------
# INSTALL DEPENDENCIES
#-----------------------------------------------
RUN apk add --no-cache bash curl openssl wget sudo git && \
  rm -rf /var/cache/apk/*

#-----------------------------------------------
# INSTALL VKPR (root)
#-----------------------------------------------
RUN curl -fsSL https://get.vkpr.net/ | bash && \
  rm -rf /tmp/*
RUN env > env.txt
#-----------------------------------------------
# INSTALL CI/CD tools (root)
#-----------------------------------------------
RUN mkdir -p tmp && cd tmp && \
    ARCH=$(uname -m) && \
    VARIANT=$( [ "$ARCH" = "aarch64" ] && echo "arm64" || echo "amd64" ) && \
    wget https://github.com/digitalocean/doctl/releases/download/v1.94.0/doctl-1.94.0-linux-$VARIANT.tar.gz -q -O doctl.tar.gz && \
    tar xf doctl.tar.gz && \
    mv doctl /usr/local/bin

ENV PATH="${PATH}:/root/.vkpr/bin/"

RUN helm plugin install https://github.com/databus23/helm-diff

#RUN rit update repo --name="vkpr-cli" --version=$VKPR_VERSION

COPY vkpr.sh /usr/local/bin/vkpr
RUN chmod +x /usr/local/bin/vkpr
