#!/usr/bin/env bash


CMD="$(readlink -f "$0")"
BASE="$(dirname "$CMD")"

cd "$BASE"

CONFS="confs"

find "$CONFS" -type f | while read conf_file; do
  # Location to link the file to relative to $HOME
  LINK_LOC="${conf_file#confs/}"

  echo ln -s "$conf_file" "$HOME/$LINK_LOC"
  ln -s "$conf_file" "$HOME/$LINK_LOC"

done
