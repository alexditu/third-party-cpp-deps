#!/bin/sh

BUILD_DIR="builddir"
if [ $# -eq 1 ]; then
	BUILD_DIR="$1"
fi

echo "Using build directory: ${BUILD_DIR}"

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}" || (echo "cd to ${BUILD_DIR} failed"; exit)

cmake .. -DCMAKE_INSTALL_PREFIX=install
cmake --build . --target install
cmake --build . --target package

sha256sum "third_party_cpp_deps.tar.gz"
