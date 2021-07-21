#!/usr/bin/env bash

##  This file is part of scilla.
##
##  Copyright (c) 2018 - present Zilliqa Research Pvt. Ltd.
##  
##  scilla is free software: you can redistribute it and/or modify it under the
##  terms of the GNU General Public License as published by the Free Software
##  Foundation, either version 3 of the License, or (at your option) any later
##  version.
## 
##  scilla is distributed in the hope that it will be useful, but WITHOUT ANY
##  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
##  A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
## 
##  You should have received a copy of the GNU General Public License along with
##  scilla.  If not, see <http://www.gnu.org/licenses/>.

# This script is expected to be executed from Scilla root
# $./scripts/libff.sh
# The script builds and installs libff in the
# _build directory of Scilla root.

source ./deps/emsdk/emsdk_env.sh

libCryptoUtilsdir="deps/cryptoutils"
cwd="$PWD"

# Check if CWD has `package.json`, assuring us that it's the root.
if [[ ! -f package.json ]]
then
   echo "Please run this script from OVN root"
   exit 1
fi

# If there's already a built version available, exit early.
if [[ -f ${libCryptoUtilsdir}/install/lib/libCryptoUtils.a ]]
then
    echo "Found libCryptoUtils.a, not building again"
    exit 0
fi

cd $libCryptoUtilsdir || exit
mkdir -p build install
cd src || exit

echo "Installing libCryptoUtils into ${libCryptoUtilsdir}/install"
cd ../build || exit
if ! emcmake cmake ../src -DCMAKE_INSTALL_PREFIX=../install -DCRYPTOUTILS_BUILD_ARCHIVE=1 -DOPENSSL_ROOT_DIR=/usr/local/opt/openssl@1.1 -DOPENSSL_INCLUDE_DIR=/usr/local/opt/openssl@1.1/include -DOPENSSL_CRYPTO_LIBRARY=/usr/local/opt/openssl@1.1/lib -DOPENSSL_LIBRARIES=/usr/local/opt/openssl@1.1/lib -DOPENSSL_SSL_LIBRARY=/usr/local/opt/openssl@1.1/lib -DBoost_INCLUDE_DIR=$cwd/deps/boost_1_64_0 -DBOOST_ROOT=$cwd/deps/boost_1_64_0 -DBoost_SYSTEM_LIBRARY=$cwd/deps/boost_1_64_0/stage/lib/libboost_system.bc -DGMP_INCLUDE_DIR=/usr/local/include -DGMP_LIBRARY=/usr/local/lib/libgmp.dylib
#if ! emcmake cmake ../src -DCMAKE_INSTALL_PREFIX=../install -DCRYPTOUTILS_BUILD_ARCHIVE=1 
then
    echo "libCryptoUtils: CMake configuration failed"
    exit 1
fi

if ! emmake make VERBOSE=1 -j4 install
then
    echo "libCryptoUtils: build failed"
    exit 1
fi

echo "libCryptoUtils: installation complete"
