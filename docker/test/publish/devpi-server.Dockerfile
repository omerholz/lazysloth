FROM python:3.12-bookworm

ARG USER_NAME
ARG USER_PASSWORD
ARG USER_INDEX=root
ENV USER_NAME=${USER_NAME}
ENV USER_PASSWORD=${USER_PASSWORD}
ENV USER_INDEX=${USER_INDEX}

WORKDIR /devpi


RUN pip install -U devpi-server
RUN pip install -U devpi-web
RUN pip install -U devpi-client

RUN devpi-init

COPY scripts/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh
HEALTHCHECK --interval=10s --timeout=10s --start-period=5s --retries=5 CMD /usr/local/bin/healthcheck.sh

COPY scripts/devpi_server_entrypoint.sh entrypoint-server.sh


ENTRYPOINT ["/devpi/entrypoint-server.sh"]
