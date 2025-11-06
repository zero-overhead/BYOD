#!/usr/bin/env bash
#
# sh -c "$(curl -H 'Pragma: no-cache' -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/fetch_BYOD.sh)"
# or
# curl -H 'Pragma: no-cache' -fsSL https://raw.githubusercontent.com/zero-overhead/BYOD/refs/heads/main/fetch_BYOD.sh | sh
#

PROJECT=BYOD
cd $HOME
if [ -d $PROJECT ]; then
  if [ -d $PROJECT.old ]; then
    rm -rf $PROJECT.old
  fi
  mv $PROJECT $PROJECT.old
fi

printf -- '-%.0s' {1..80}; printf '\n'
echo "git clone --depth 1 --recurse-submodules https://github.com/zero-overhead/$PROJECT $HOME/BYOD"
git clone --depth 1 --recurse-submodules https://github.com/zero-overhead/$PROJECT $HOME/BYOD
