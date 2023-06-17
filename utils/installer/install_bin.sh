#!/usr/bin/env bash
set -eo pipefail

INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"

XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

NVIM_APPNAME="${NVIM_APPNAME:-tnotes}"

TOWERNOTES_RUNTIME_DIR="${TOWERNOTES_RUNTIME_DIR:-"$XDG_DATA_HOME/towernotes"}"
TOWERNOTES_CONFIG_DIR="${TOWERNOTES_CONFIG_DIR:-"$XDG_CONFIG_HOME/$NVIM_APPNAME"}"
TOWERNOTES_CACHE_DIR="${TOWERNOTES_CACHE_DIR:-"$XDG_CACHE_HOME/$NVIM_APPNAME"}"
TOWERNOTES_BASE_DIR="${TOWERNOTES_BASE_DIR:-"$TOWERNOTES_RUNTIME_DIR/$NVIM_APPNAME"}"

function setup_shim(){
  local src="$TOWERNOTES_BASE_DIR/utils/bin/tnotes.template"
  local dst="$INSTALL_PREFIX/bin/$NVIM_APPNAME"
  
  [ ! -d "$INSTALL_PREFIX/bin" ] && mkdir -p "$INSTALL_PREFIX/bin"

  # remove outdated installation so that `cp` doesn't complain
  rm -f "$dst"

  cp "$src" "$dst"

  sed -e s"#NVIM_APPNAME_VAR#\"${NVIM_APPNAME}\"#"g \
    -e s"#RUNTIME_DIR_VAR#\"${LUNARVIM_RUNTIME_DIR}\"#"g \
    -e s"#CONFIG_DIR_VAR#\"${LUNARVIM_CONFIG_DIR}\"#"g \
    -e s"#CACHE_DIR_VAR#\"${LUNARVIM_CACHE_DIR}\"#"g \
    -e s"#BASE_DIR_VAR#\"${LUNARVIM_BASE_DIR}\"#"g "$src" \
    | tee "$dst" >/dev/null

  chmod u+x "$dst"
}

setup_shim "$@"

echo "You can start TowerNotes by running: $INSTALL_PREFIX/bin/$NVIM_APPNAME"
