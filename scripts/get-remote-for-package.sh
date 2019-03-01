#!/usr/bin/env bash
set -euv

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a package name}

PACKAGE=$1

# Some packages names do not correspond to their repository name.  They should
# have a `remote` field in `configuration.nix` to point to the right repository.
REMOTE=`nix-instantiate --eval -E "(import ${GALOIS}/configuration.nix).${PACKAGE}.remote or \"${PACKAGE}\""`

# Remove the quotes around the string
echo ${REMOTE} | tr -d '"'
