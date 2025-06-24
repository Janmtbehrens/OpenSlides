#!/bin/bash
# This script runs a command in every registered submodule parallel
# Credits go to https://stackoverflow.com/a/70418086

if [ -z "$1" ]; then
    echo "Missing Command" >&2
    exit 1
fi

COMMAND="$*"

IFS=$'\n'
for DIR in $(git submodule foreach --recursive -q sh -c pwd); do
    printf "\n\"%s\": \"%s\" started!\n" "${DIR}" "${COMMAND}"\
    && \
    cd "$DIR" || exit 1 \
    && \
    eval "$COMMAND" \
    && \
    printf "\"%s\": \"%s\" finished!\n" "${DIR}" "${COMMAND}" \
    &
done
wait