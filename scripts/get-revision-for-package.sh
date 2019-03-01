#!/usr/bin/env bash
set -euv

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a package name}

PACKAGE=$1

REVISION=`nix-instantiate --eval -E "(import ${GALOIS}/configuration.nix).${PACKAGE}.rev or \"master\""`

# Remove the quotes around the string
echo ${REVISION} | tr -d '"'
