#!/usr/bin/env bash
set -euv

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a package name}

PACKAGE=$1

BRANCH=`nix-instantiate --eval -E "(import ${GALOIS}/configuration.nix).${PACKAGE}.branch or \"master\""`

# Remove the quotes around the string
echo ${BRANCH} | tr -d '"'
