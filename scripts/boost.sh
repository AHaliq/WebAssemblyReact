#!/usr/bin/env bash

if [[ -d "./deps/boost_1_64_0" ]]
then
    echo "Found boost, not building again"
    exit 0
fi

source ./deps/emsdk/emsdk_env.sh

cd ./deps
curl -L -O "https://boostorg.jfrog.io/artifactory/main/release/1.64.0/source/boost_1_64_0.tar.gz"
tar -xzvf boost_1_64_0.tar.gz
rm *.tar.gz
cd boost_1_64_0
./bootstrap.sh
./b2 toolset=emscripten link=static runtime-link=static --with-system --with-thread
cd ../../