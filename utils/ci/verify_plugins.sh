#!/usr/bin/env bash
set -e

BASEDIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
BASEDIR="$(dirname -- "$(dirname -- "$BASEDIR")")"

TOWERNOTES_BASE_DIR="${TOWERNOTES_BASE_DIR:-"$BASEDIR"}"

tnotes --headless \
  -c "luafile ${TOWERNOTES_BASE_DIR}/utils/ci/verify_plugins.lua"
