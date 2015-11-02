#!/bin/sh

set -eux

cd "$(dirname "$0")"
TAG="$USER/${PWD##*/}"

exec docker build --rm -t "$TAG" .

