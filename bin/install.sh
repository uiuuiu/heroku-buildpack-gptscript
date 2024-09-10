#!/bin/bash
# bin/compile <build-dir> <cache-dir> <env-dir>

## Configure environment (fail test)
set -e

## Buildpack directory
readonly BP_DIR=$(cd "$(dirname "${0:-}")"/..; pwd) # absolute path

readonly BUILD_DIR="${1:-}"
readonly CACHE_DIR="${2:-}"

GPTSCRIPT_FILENAME='gptscript-v0.9.4-linux-amd64.tar.gz'
GPTSCRIPT_INSTALLATION_URL="https://github.com/gptscript-ai/gptscript/releases/download/v0.9.4/${GPTSCRIPT_FILENAME}"

echo "    -> Downloading VIM... (${AMZ_VIM_URL})"

curl --retry 2 --silent --max-time 60 --location "${GPTSCRIPT_INSTALLATION_URL}" --output "${CACHE_DIR}/${GPTSCRIPT_FILENAME}"

# install
echo "    -> Installing gptscript..."

mkdir -p "$BUILD_DIR/gptscript"
tar -xf "${CACHE_DIR}/${GPTSCRIPT_FILENAME}" -C "${BUILD_DIR}/gptscript"

# export
PROFILE_PATH="$BUILD_DIR/.profile.d/gptscript.sh"
mkdir -p $(dirname $PROFILE_PATH)
echo 'export PATH=$PATH:/app/gptscript' >> $PROFILE_PATH

echo "    DONE"
