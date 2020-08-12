FROM ludeeus/container:python

COPY runaction.sh /runaction.sh
RUN \
    apk add --no-cache \
        jq \
        libxml2 \
        libxslt \
        zlib-dev

# Install homeassistant
RUN python3 -m pip install --disable-pip-version-check homeassistant

ENTRYPOINT ["bash", "/runaction.sh"]
