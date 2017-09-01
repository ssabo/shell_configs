#!/usr/bin/env bash
# Author: Shaun Sabo
# Links conf files into place in $HOME as well as a bin directory
# Will automatically delete old symlinks. Will not delete directories or files though

platform="$(uname)"
if [ "$platform" == 'Darwin' ]; then
  READLINK="$(which greadlink)"
elif [ "$platform" == "Linux" ]; then
  READLINK="$(which readlink)"
else
  echo "Cannot determine plaform"
  exit 1
fi

if [ ! -f "$READLINK" ]; then
  echo "Please install coreutils"
  exit 1
fi

CMD="$($READLINK -f "$0")"
BASE="$(dirname "$CMD")"
CONFS="confs"

# Do work relative to base dir
cd "$BASE" || exit 1

# Link $HOME/bin
test -L "$HOME/bin" && rm "$HOME/bin"
echo ln -s "$BASE/bin" "$HOME/bin"
ln -s "$BASE/bin" "$HOME/bin"

# Link conf files
find "$CONFS" -type f | while read -r conf_file; do
  # Location to link the file to relative to $HOME
  LINK_LOC="${conf_file#confs/}"

  test -L "$HOME/$LINK_LOC" && rm "$HOME/$LINK_LOC"

  echo ln -s "$BASE/$conf_file" "$HOME/$LINK_LOC"
  ln -s "$BASE/$conf_file" "$HOME/$LINK_LOC"

done

if [ ! -e "$HOME/.vim/bundle/Vundle.vim" ]; then
  echo "Installing Vundle"
  mkdir -p "$HOME/.vim/bundle"a
  pushd "$HOME/.vim/bundle"
  git clone git@github.com:ssabo/shell_configs.git
  popd
fi
