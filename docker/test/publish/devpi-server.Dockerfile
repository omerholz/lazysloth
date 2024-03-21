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

COPY scripts/devpi_server_entrypoint.sh entrypoint-server.sh

ENTRYPOINT ["/devpi/entrypoint-server.sh"]
