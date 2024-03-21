FROM python:3.10-bookworm

RUN pip install pipenv
RUN pip install toml-cli

WORKDIR /library

COPY Pipfile Pipfile.lock ./
RUN pipenv sync --dev

COPY README.md pyproject.toml ./
COPY docker/test/publish/scripts/uploader_entrypoint.sh ./entrypoint.sh
COPY src/ ./src


COPY tests/ ./tests

CMD ["/library/entrypoint.sh"]

