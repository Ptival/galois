#!/usr/bin/env bash
set -euv

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a package name}

PACKAGE=$1

OWNER=`nix-instantiate --eval -E "(import ${GALOIS}/configuration.nix).${PACKAGE}.owner or \"GaloisInc\""`

# Remove the quotes around the string
echo ${OWNER} | tr -d '"'
