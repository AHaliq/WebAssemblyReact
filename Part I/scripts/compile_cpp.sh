#!/usr/bin/env bash

source ./deps/emsdk/emsdk_env.sh

mkdir -p _build
emcc -O3 --bind cpp/bindings/SampleBindings.cpp -Icpp/ cpp/src/*.cpp -s WASM=1 -s MODULARIZE=1 -o ./_build/Sample.js