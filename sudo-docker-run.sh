#!/bin/sh

# The script docker-run.sh uses some environmental variables which root may not know.
# This script enables us to pass these variables to root.

sudo "DISPLAY=${DISPLAY}" "XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR}" "MYHOME=${HOME}" ./docker-run.sh "$@"
