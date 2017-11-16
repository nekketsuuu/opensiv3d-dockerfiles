#!/bin/sh

set -ex

TAGNAME="$(grep -oP --color=never 'version="\K.+(?=" \\)' ./docker/Dockerfile)"
docker build --tag "nekketsuuu/opensiv3d-linux:$TAGNAME" ./docker
