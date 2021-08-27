#!/bin/sh

# Force stop when an error occured
set -o errexit

# Get current directory
working_dir=$(dirname $(realpath $0))
echo "Current directory is: ${working_dir}"

echo "Cloning OpenImageDenoise... (~300 mb)"
git clone --recursive https://github.com/OpenImageDenoise/oidn.git oidn

echo "Downloading and extracting ISPC (~45 mb)..."
curl -L -o ispc-linux.tar.gz https://github.com/ispc/ispc/releases/download/v1.16.1/ispc-v1.16.1-linux.tar.gz
mkdir -p ispc
tar -xvf ispc-linux.tar.gz --strip-components=1 -C ispc/
rm -f ispc-linux.tar.gz

echo "Setting ISPC env variable"
export ISPC_EXECUTABLE=${working_dir}/ispc/bin/ispc
echo "ISPC Directory: ${ISPC_EXECUTABLE}"

echo "Building OpenImageDenoise..."
cd oidn
mkdir -p build
cd build
cmake -DISPC_EXECUTABLE=${ISPC_EXECUTABLE} ..
make -j