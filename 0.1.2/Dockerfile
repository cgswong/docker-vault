# Docker file to run Hashicorp Vault (vaultproject.io)

FROM gliderlabs/alpine:3.3
MAINTAINER Stuart Wong <cgs.wong@gmail.com>

ENV VAULT_VERSION 0.1.2
ENV VAULT_TMP /tmp/vault.zip
ENV VAULT_HOME /usr/local/bin
ENV PATH $PATH:${VAULT_HOME}

RUN apk --no-cache add \
      bash \
      ca-certificates \
      wget &&\
    wget --quiet --output-document=${VAULT_TMP} https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip &&\
    unzip ${VAULT_TMP} -d ${VAULT_HOME} &&\
    rm -f ${VAULT_TMP}

# Listener API tcp port
EXPOSE 8200

ENTRYPOINT ["/usr/local/bin/vault"]
CMD ["version"]
