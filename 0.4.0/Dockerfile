# Docker file to run Hashicorp Vault (vaultproject.io)

FROM gliderlabs/alpine:3.3
MAINTAINER Stuart Wong <cgs.wong@gmail.com>

ENV VAULT_VERSION 0.4.0
ENV VAULT_TMP /tmp/vault.zip
ENV VAULT_HOME /usr/local/bin
ENV PATH $PATH:${VAULT_HOME}

RUN apk --no-cache add \
    ca-certificates && \
    cd /tmp && \
    wget -q https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    mv vault_${VAULT_VERSION}_linux_amd64.zip ${VAULT_TMP} && \
    unzip ${VAULT_TMP} -d ${VAULT_HOME} && \
    rm -f ${VAULT_TMP} && \
    apk --no-cache del ca-certificates

# Listener API tcp port
EXPOSE 8200

ENTRYPOINT ["/usr/local/bin/vault"]
CMD ["version"]
