FROM k8sathome/ubuntu:latest

ARG VERSION
ARG TARGETPLATFORM

USER root

RUN \
  apt-get -qq update \
  && \
  apt-get -qq install -y --no-install-recommends --no-install-suggests \
    openjdk-8-jre-headless \
  && \
  curl -fsSL -o /app/Geyser.jar \                                                   
    "https://ci.nukkitx.com/job/GeyserMC/job/Geyser/job/master/$VERSION/artifact/bootstrap/standalone/target/Geyser.jar" \
  && echo "UpdateMethod=docker\nPackageVersion=${VERSION}\nPackageAuthor=[Team k8s-at-home](https://github.com/k8s-at-home)" > /app/package_info \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
  && chmod -R u=rwX,go=rX /app \
  && echo umask ${UMASK} >> /etc/bash.bashrc

USER kah

EXPOSE 19132/udp

COPY ./geysermc/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
