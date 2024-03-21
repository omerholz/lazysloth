FROM python:3.10-bookworm

WORKDIR /test

COPY scripts/test_package.sh scripts/test_package.py ./

CMD ["/bin/bash", "-c", "./test_package.sh"]

