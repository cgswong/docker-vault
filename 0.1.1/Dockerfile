# ################################################################
# DESC: Docker file to run Hashicorp Vault (vaultproject.io)
#
# LOG:
# yyyy/mm/dd [name] [version]: [notes]
# 2015/05/01 cgwong [v0.1.0]: Initial creation.
# ################################################################

FROM gliderlabs/alpine:3.1
MAINTAINER Stuart Wong <cgs.wong@gmail.com>

ENV VAULT_VERSION 0.1.1
ENV VAULT_TMP /tmp/vault.zip
ENV VAULT_HOME /usr/local/bin
ENV PATH $PATH:${VAULT_HOME}

RUN apk --update add \
      wget \
      bash \
      ca-certificates &&\
    wget --no-check-certificate --quiet --output-document=${VAULT_TMP} https://dl.bintray.com/mitchellh/vault/vault_${VAULT_VERSION}_linux_amd64.zip &&\
    unzip ${VAULT_TMP} -d ${VAULT_HOME} &&\
    rm -f ${VAULT_TMP}

# Listener API tcp port
EXPOSE 8200

ENTRYPOINT ["/usr/local/bin/vault"]
CMD ["version"]
