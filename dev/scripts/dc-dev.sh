#!/bin/bash
cd "$(dirname "$0")" || exit 1
docker compose -f ../docker/docker-compose.dev.yml "$@"
