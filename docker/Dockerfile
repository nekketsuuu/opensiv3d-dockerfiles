FROM nekketsuuu/boost:1.65.0_gcc-7_ubuntu-16.04

LABEL version="0.1.7.1900-Debug" \
      maintainer="nekketsuuu <nekketsuuu+docker@gmail.com>"

ENV FREETYPE_VERSION=2.8.1 \
    WORK_DIR=/root

# Note: Additionaly, BOOST_PREFIX and BOOST_VERSION is set in nekketsuuu/boost

# Get libraries
# Note: We build FreeType from the source since the libfreetype6-dev package is old (version 2.6.1)
# Note: Packages alsa-base, alsa-utils and pulseaudio are needed when running an exe on a container
#
#   1. Do `apt-get install` almost all libraries
#   2. Clean APT cache
#   3. Make static links of gcc/g++
#   4. Configure the path of libturbojpeg (not libjpeg)
#   5. Make FreeType && install
#   6. Clean all

RUN apt-get update -y \
 && apt-get install --no-install-recommends -y \
      cmake \
      git \
      libgif-dev \
      libgl1-mesa-dev \
      libglew-dev \
      libglib2.0-dev \
      libglu1-mesa-dev \
      libjpeg-dev \
      libopenal-dev \
      libpng16-dev \
      libx11-dev \
      libxcursor-dev \
      libxi-dev \
      libxinerama-dev \
      libxrandr-dev \
      wget \
 && apt-get install -y \
      alsa-base \
      alsa-utils \
      pulseaudio \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && cd /usr/lib/x86_64-linux-gnu/pkgconfig \
 && echo 'prefix=/usr'                            > libturbojpeg.pc \
 && echo 'exec_prefix=${prefix}'                 >> libturbojpeg.pc \
 && echo 'libdir=${prefix}/lib/x86_64-linux-gnu' >> libturbojpeg.pc \
 && echo 'includedir=${prefix}/include'          >> libturbojpeg.pc \
 && echo                                         >> libturbojpeg.pc \
 && echo 'Name: libturbojpeg'                    >> libturbojpeg.pc \
 && echo 'Description: Turbo JPEG image codec'   >> libturbojpeg.pc \
 && echo 'Version: '                             >> libturbojpeg.pc \
 && echo 'Libs: -L${libdir} -lturbojpeg'         >> libturbojpeg.pc \
 && echo 'Cflags: -I${includedir}'               >> libturbojpeg.pc \
 && cd ${WORK_DIR} \
 && wget http://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE_VERSION}.tar.gz \
 && tar xf freetype-${FREETYPE_VERSION}.tar.gz \
 && cd ./freetype-${FREETYPE_VERSION} \
 && ./configure \
 && make \
 && make install \
 && rm -rf ${WORK_DIR}/*

# Build OpenSiv3D
#
#   1. Get code
#   2. Configure makefile
#   3. Make
#   4. Install
#   5. Set library paths
#   6. Clean up

ENV OPENSIV3D_GIT=https://github.com/wynd2608/OpenSiv3D.git \
    OPENSIV3D_SHA=c6512ba49c73a6458062cdc37b43810c20fb37aa \
    OPENSIV3D_BUILD_TYPE=Debug

RUN cd ${WORK_DIR} \
 && git clone ${OPENSIV3D_GIT} \
 && cd ./OpenSiv3D \
 && git reset --hard ${OPENSIV3D_SHA} \
 && sed -i '/::glfwMakeContextCurrent(m_glfwWindow);/a ::glewExperimental = GL_TRUE;' ./Siv3D/Source/Siv3D/Window/CWindow_Linux.cpp \
 && cd ./Linux \
 && sed -i "/include_directories(/a \\\t\"${BOOST_PREFIX}/include\"" CMakeLists.txt \
 && sed -i 's/set(CMAKE_CXX_COMPILER/# set(CMAKE_CXX_COMPILER/g' CMakeLists.txt \
 && sed -i 's/set(CMAKE_C_COMPILER/# set(CMAKE_C_COMPILER/g' CMakeLists.txt \
 && mkdir -p "${OPENSIV3D_BUILD_TYPE}" \
 && cd "./${OPENSIV3D_BUILD_TYPE}" \
 && cmake \
      -DCMAKE_BUILD_TYPE="${OPENSIV3D_BUILD_TYPE}" \
      -DCMAKE_C_COMPILER=gcc \
      -DCMAKE_CXX_COMPILER=g++ \
      -DCMAKE_CXX_FLAGS="-std=c++17 -Wall -Wextra -Wno-unknown-pragmas -fPIC" \
      -DCMAKE_CXX_FLAGS_RELEASE="-O2 -DNDEBUG -march=x86-64" \
      -DCMAKE_CXX_FLAGS_DEBUG="-g3 -O0 -pg" \
      .. \
 && make \
 && cp ./libSiv3D.a /usr/local/lib/ \
 && mkdir -p /usr/local/Siv3D/Lib \
 && cp -r ${WORK_DIR}/OpenSiv3D/Siv3D/Include /usr/local/Siv3D/Include \
 && cp -r ${WORK_DIR}/OpenSiv3D/Siv3D/Lib/Linux /usr/local/Siv3D/Lib/Linux \
 && echo '/usr/local/lib' >> /etc/ld.so.conf \
 && echo '# OpenSiv3D libraries'       > /etc/ld.so.conf.d/siv3d.conf \
 && echo '/usr/local/Siv3D/Lib/Linux' >> /etc/ld.so.conf.d/siv3d.conf \
 && ldconfig \
# && rm -rf ${WORK_DIR}/*
