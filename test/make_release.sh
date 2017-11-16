#!/bin/sh

if [ $# -ne 1 ]; then
	echo "usage : $0 [file].cpp"
	exit 1
fi

g++ \
  --std=c++17 \
  -Wall -Wextra -Wno-unknown-pragmas \
  -I/usr/local/Siv3D/Include \
  -I/usr/include \
  -O2 -DNDEBUG -march=native \
  -o "$1" \
  "$1.cpp" \
  /usr/local/lib/libSiv3D.a \
  /usr/local/Siv3D/Lib/Linux/harfbuzz/libharfbuzz.a \
  /usr/local/Siv3D/Lib/Linux/angelscript/libangelscript.a \
  -lboost_filesystem \
  -lboost_system \
  -lglib-2.0 \
  -lgio-2.0 \
  -lgobject-2.0 \
  -lpthread \
  -lGL \
  -lopenal \
  -lpng \
  -lturbojpeg \
  -lX11 \
  -lXi \
  -lXrandr \
  -lXinerama \
  -lXcursor \
  -ldl \
  -lgif \
  -lGLEW \
  -lfreetype
