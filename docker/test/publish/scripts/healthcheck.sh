#!/bin/sh
# Check if the container is ready

if [ -f /tmp/container_ready ]; then
    exit 0
else
    exit 1
fi
