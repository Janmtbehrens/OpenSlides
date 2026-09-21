#!/bin/bash

# This script builds the zitadel login image from a local fork
# Afterwards, the user may restart their docker setup to take the newly build image into effect

set -eo pipefail

# Import OpenSlides utils package
# shellcheck disable=SC1091
. "$(dirname "$0")/../util.sh"

ZITADEL_PATH=${ZITADEL_PATH:-"../zitadel/zitadel"}

CUR="$(realpath $(dirname "$0"))"

{
    cd "$ZITADEL_PATH"/apps/login || exit 1
    pnpm install
    # Test compile time integrity before building
    pnpm nx run @zitadel/login:test-unit --tuiAutoExit
    # Build
    pnpm nx run @zitadel/login:pack --tuiAutoExit
    cd "$CUR/../../.." || exit 1
}

#ask y "Restart Zitadel Login Container? Requires full restart" || exit 0
make dev-stop || true
make dev-detached || true
make dev-log-attach zitadel-login || true

