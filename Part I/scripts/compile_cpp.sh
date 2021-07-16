#!/usr/bin/env bash

emcc -O3 --bind bindings/SampleBindings.cpp -Icpp/ cpp/*.cpp deps/cryptoutils/install/include/*/* -s WASM=1 -s MODULARIZE=1 -o Sample.js