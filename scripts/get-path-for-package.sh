#!/usr/bin/env bash
set -euv

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a package name}

PACKAGE=$1

PACKAGEPATH=`nix-instantiate --eval -E "(import ${GALOIS}/configuration.nix).${PACKAGE}.path or \".\""`

# Remove the quotes around the string
echo ${PACKAGEPATH} | tr -d '"'
