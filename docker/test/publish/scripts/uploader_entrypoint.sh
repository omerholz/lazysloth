#!/bin/bash

toml set --toml-path pyproject.toml project.version $LAZYSLOTH_VERSION
pipenv run hatch build
pipenv run twine upload -u $PYPISERVER_USERNAME -p $PYPISERVER_PASSWORD --repository-url $PYPISERVER_PROTOCOL://$PYPISERVER_HOST:$PYPISERVER_PORT/$PYPISERVER_INDEX dist/*

