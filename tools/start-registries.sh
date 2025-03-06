#!/usr/bin/env bash

# Ref: https://www.talos.dev/v1.9/talos-guides/configuration/pull-through-cache/

# Starting port for contianers
PORT=5000

#
REMOTES=(
    https://registry-1.docker.io
    https://registry.k8s.io
    https://gcr.io
    https://ghcr.io
)

for URL in "${REMOTES[@]}"; do
    BASE=$(sed 's#^.*[/.]\([^.]\+\.[^.]\+\)#\1#' <<< "$URL")
    podman run \
        --detach \
        --restart always \
        --publish $PORT:5000 \
        --name registry-$BASE \
        --env REGISTRY_PROXY_REMOTEURL="$URL" \
        docker.io/library/registry:latest
    (( PORT += 1 ))
done
