## OpenSiv3D on Docker

[WIP] Dockerfiles for [OpenSiv3D](https://github.com/Siv3D/OpenSiv3D) on Linux

## Prerequisites / 事前に必要なもの

* Docker
* Sound system such as PulseAudio and ALSA (probably installed at default)
* X11 (Wayland and Mir is not supported)
* Graphics system which supports OpenGL >=4.1 (You can verify it by `glxinfo | grep version`)

I tested on Ubuntu 17.04 with PulseAudio, ALSA and X11.

* Docker
* PulseAudio & ALSA のような音響系 (大抵デフォルトでインストールされています)
* X11 (Wayland と Mir はサポートしていません)
* OpenGL 4.1 以上が使えるグラフィクス系 (`glxinfo | grep version` を実行することで確かめられます)

動作は PulseAudio, ALSA, X11 の入った Ubuntu 17.04 上で確認しています。

## Quickstart / 動作例

```sh
git clone https://github.com/nekketsuuu/opensiv3d-dockerfiles.git
cd opensiv3d-dockerfiles
./sudo-docker-run.sh 0.1.7.1900-Debug
# on a container...
cd /var/work/test
./make_debug.sh test
./test
```

## Usage / 使い方

### Run app on a container / アプリをコンテナ上で動かす場合

If you want to run a Siv3D application on a container, check `docker-run.sh`. In order to use audio/graphics devices in the container, some options are needed for `docker run`.

Siv3D を使ったアプリをコンテナの上で動かしたい場合、`docker-run.sh` を参考にしてください。音声・画像系のデバイスをコンテナから使えるようにするため、`docker run` にいくつかのオプションが必要です。

```sh
# If you need sudo... / sudo が必要な場合
./sudo-docker-run.sh 0.1.7.1900-Debug
# If you don't need sudo... / sudo が不要な場合
./docker-run.sh 0.1.7.1900-Debug
```

Also, check `test/make_debug.sh` or `test/make_release.sh` to know how to build an app with the Siv3D library.

また、Siv3D アプリをどのようにビルドするかに関しては、`test/make_debug.sh` または `test/make_release.sh` を参考にしてください。

```sh
# On the container...
cd /var/work/test
./make_debug.sh test
./test
```

### Run app on host / アプリをホストで動かす場合

If you want to run outside a container, you will need several libraries.

コンテナの外でアプリを動かしたい場合、いくつかライブラリが必要なはずです。

* libSiv3D.a ... located at `/usr/local/lib/Siv3D.a` on the container / コンテナ内の `/usr/local/lib/Siv3D.a` にあります。
* [Libraries which Siv3D needs / Siv3D が必要とするライブラリ](https://github.com/Siv3D/OpenSiv3D/tree/master/Linux)

## (For developers) Build Docker image / (開発者向け) Docker イメージのビルド

```sh
# You may need sudo / sudo が必要かもしれません
./docker-build.sh
```

(Don't forget to build the `latest` tag, too / `latest` タグもビルドするのを忘れないように)

You can publish your image via `docker push`. / `docker push` でイメージを配布できます。

```sh
# If necessary, do `docker login`. / 必要なら `docker login` をする。
docker push <image tag>
```
