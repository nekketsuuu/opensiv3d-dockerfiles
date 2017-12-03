#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Usage:"
    echo "  $0 <tag>"
    echo ""
    echo "Example:"
    echo "  $0 0.1.7.1900-Debug"
    exit 1
fi

set -ex
DOCKER_NAME=opensiv3d

# If you want to edit /proc/sys/kernel/core_pattern
# in order to config the output directory of core dump,
# then set DOCKER_PRIVILEGED to true.

DOCKER_PRIVILEGED=false

# Docker-run options
#
# In order to run Siv3D applications in a container,
#
# * OpenAL: Allow access to /dev/snd (for ALSA) or /dev/dsp (for OSS)
#     * PulseAudio & ALSA: set PULSE_SERVER, add user to the `audio` group, share a cookie
#     * Ref: https://askubuntu.com/q/972510/644471
# * X11: Allow access to /tmp/.X11-unix. Set $DISPLAY. xhost +.
#     * If you use older version of Docker, you may need --privileged option
#     * Ref: https://github.com/moby/moby/issues/8710
#     * Ref: https://unskilled.site/dockerコンテナの中でguiアプリケーションを起動させる/
# * OpenGL: Allow access to /dev/dri (Intel only?)
#     * Ref: http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration

sound_options="\
    --env PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
    --group-add $(getent group audio | cut -d: -f3) \
    --volume ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
    --volume ${MYHOME}/.config/pulse/cookie:/root/.config/pulse/cookie \
"

x11_options="\
    --env DISPLAY=${DISPLAY} \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
"

graphics_options="\
    --device /dev/dri \
    --group-add $(getent group video | cut -d: -f3) \
"

# Run!

docker rm --force "${DOCKER_NAME}" || true  # ignore errors
docker run \
  --detach -it \
  --name "${DOCKER_NAME}" \
  --privileged="${DOCKER_PRIVILEGED}" \
  --volume "$(pwd):/var/work" \
  ${sound_options} \
  ${x11_options} \
  ${graphics_options} \
  "nekketsuuu/opensiv3d-linux:$1" \
  /bin/bash \
&& export DOCKER_HOSTNAME="$(docker inspect --format='{{ .Config.Hostname }}' ${DOCKER_NAME})" \
&& xhost +local:"${DOCKER_HOSTNAME}" \
&& docker attach "${DOCKER_NAME}" \
&& xhost -local:"${DOCKER_HOSTNAME}"
