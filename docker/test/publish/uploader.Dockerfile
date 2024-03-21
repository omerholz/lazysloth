FROM python:3.10-bookworm

RUN pip install pipenv
RUN pip install toml-cli

WORKDIR /library

COPY Pipfile Pipfile.lock ./
RUN pipenv sync --dev

COPY docker/test/publish/scripts/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh
HEALTHCHECK --interval=10s --timeout=10s --start-period=5s --retries=5 CMD /usr/local/bin/healthcheck.sh

COPY README.md pyproject.toml ./
COPY docker/test/publish/scripts/uploader_entrypoint.sh ./entrypoint.sh
COPY src/ ./src

COPY tests/ ./tests

CMD ["/library/entrypoint.sh"]

