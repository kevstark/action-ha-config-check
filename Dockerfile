FROM ludeeus/container:python

RUN \
    apk add --no-cache \
        jpeg-dev \
        jq \
        libxml2 \
        libxslt \
        zlib-dev

# Copy in the Home Assistant version number to ensure rebuild on version change
COPY .HA_VERSION /.HA_VERSION

# Install homeassistant
COPY requirements.txt .
RUN python3 -m pip install --disable-pip-version-check -r requirements.txt

COPY runaction.sh /runaction.sh

ENTRYPOINT ["bash", "/runaction.sh"]
