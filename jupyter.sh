#!/usr/bin/env bash

# default document directory
DOCUMENTS_DIR="$HOME/Dokumente"
BYOD="$HOME/BYOD"

# in case not German system, perhaps English?
if [ ! -d "$DOCUMENTS_DIR" ]; then
    DOCUMENTS_DIR="$HOME/Documents"
fi
# set default to $HOME
if [ ! -d "$DOCUMENTS_DIR" ]; then
    DOCUMENTS_DIR=$HOME
fi

printf -- '-%.0s' {1..80}; printf '\n'
echo "cd $BYOD"
cd $BYOD

echo "nix-shell nix-shells/jupyter-lab.nix --run 'jupyter-lab --notebook-dir=$DOCUMENTS_DIR'"
nix-shell nix-shells/jupyter-lab.nix --run "jupyter-lab --notebook-dir=$DOCUMENTS_DIR"
