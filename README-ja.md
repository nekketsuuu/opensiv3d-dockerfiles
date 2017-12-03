## OpenSiv3D on Docker

Linux on Docker で OpenSiv3D を動かす Dockerfile のレポジトリです。

[English version of this README is here.](https://github.com/nekketsuuu/opensiv3d-dockerfiles/blob/master/README.md)

## 事前に必要なもの

* Docker
* PulseAudio & ALSA のような音響系 (大抵デフォルトでインストールされています)
* X11 (Wayland と Mir はサポートしていません)
* OpenGL 4.1 以上が使えるグラフィクス系 (`glxinfo | grep version` を実行することで確かめられます)

動作は PulseAudio, ALSA, X11 の入った Ubuntu 17.04 上で確認しています。

## 動作例

```sh
git clone https://github.com/nekketsuuu/opensiv3d-dockerfiles.git
cd opensiv3d-dockerfiles
./sudo-docker-run.sh 0.1.7.1900-Debug
# on a container...
cd /var/work/test
./make_debug.sh test
./test
```

## 使い方

### アプリをコンテナ上で動かす場合

Siv3D を使ったアプリをコンテナの上で動かしたい場合、`docker-run.sh` を参考にしてください。音声・画像系のデバイスをコンテナから使えるようにするため、`docker run` にいくつかのオプションが必要です。

```sh
# sudo が必要な場合
./sudo-docker-run.sh 0.1.7.1900-Debug
# sudo が不要な場合
./docker-run.sh 0.1.7.1900-Debug
```

また、Siv3D アプリをどのようにビルドするかに関しては、`test/make_debug.sh` または `test/make_release.sh` を参考にしてください。

```sh
# コンテナ上
cd /var/work/test
./make_debug.sh test
./test
```

### アプリをホストで動かす場合

コンテナの外でアプリを動かしたい場合、いくつかライブラリが必要なはずです。

* libSiv3D.a ... コンテナ内の `/usr/local/lib/Siv3D.a` にあります。
* [Siv3D が必要とするライブラリ](https://github.com/Siv3D/OpenSiv3D/tree/master/Linux)

## (開発者向け) Docker イメージのビルド

```sh
# sudo が必要かもしれません
./docker-build.sh
```

(`latest` タグもビルドするのを忘れないように)

`docker push` でイメージを配布できます。

```sh
# 必要なら `docker login` をする。
docker push <image tag>
```
