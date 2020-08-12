FROM ludeeus/container:python

COPY runaction.sh /runaction.sh
RUN \
    apk add --no-cache \
        jq \
        libxml2 \
        libxslt \
        zlib-dev

# Install homeassistant
COPY requirements.txt .
RUN python3 -m pip install --disable-pip-version-check -r requirements.txt

ENTRYPOINT ["bash", "/runaction.sh"]
