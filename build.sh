#!/bin/sh

BUILD_DIR="builddir"
if [ $# -eq 1 ]; then
	BUILD_DIR="$1"
fi

echo "Using build directory: ${BUILD_DIR}"

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}" || (echo "cd to ${BUILD_DIR} failed"; exit)

cmake .. -DCMAKE_INSTALL_PREFIX=install -DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake
cmake --build . --parallel --target install
cmake --build . --parallel --target package

sha256sum "third_party_cpp_deps.tar.gz"
