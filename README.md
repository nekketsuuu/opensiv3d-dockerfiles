## OpenSiv3D on Docker

Dockerfiles for [OpenSiv3D](https://github.com/Siv3D/OpenSiv3D) on Linux

[日本語版 README はこちら](https://github.com/nekketsuuu/opensiv3d-dockerfiles/blob/master/README-ja.md)

## Prerequisites

* Docker
* Sound system such as PulseAudio and ALSA (probably installed at default)
* X11 (Wayland and Mir is not supported)
* Graphics system which supports OpenGL >=4.1 (You can verify it by `glxinfo | grep version`)

I tested on Ubuntu 17.04 with PulseAudio, ALSA and X11.

## Quickstart

```sh
git clone https://github.com/nekketsuuu/opensiv3d-dockerfiles.git
cd opensiv3d-dockerfiles
./sudo-docker-run.sh 0.1.7.1900-Debug
# on a container...
cd /var/work/test
./make_debug.sh test
./test
```

## Usage

### Run app on container

If you want to run a Siv3D application on a container, check `docker-run.sh`. In order to use audio/graphics devices in the container, some options are needed for `docker run`.

```sh
# If you need sudo...
./sudo-docker-run.sh 0.1.7.1900-Debug
# If you don't need sudo...
./docker-run.sh 0.1.7.1900-Debug
```

Also, check `test/make_debug.sh` or `test/make_release.sh` to know how to build an app with the Siv3D library.

```sh
# On the container...
cd /var/work/test
./make_debug.sh test
./test
```

### Run app on host

If you want to run outside a container, you will need several libraries.

* libSiv3D.a ... located at `/usr/local/lib/Siv3D.a` on the container
* [Libraries which are necessary for Siv3D](https://github.com/Siv3D/OpenSiv3D/tree/master/Linux)

## (For developers) Build Docker image

```sh
# You may need sudo
./docker-build.sh
```

(Don't forget to build the `latest` tag, too)

You can publish your image via `docker push`.

```sh
# If necessary, do `docker login`.
docker push <image tag>
```
