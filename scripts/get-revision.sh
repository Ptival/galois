#!/usr/bin/env bash
set -eu

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a project name}
: ${2?First argument should be a package name}

PROJECT=$1
PACKAGE=$1

REVISION=`nix-instantiate --eval -E "
let configuration = import ${GALOIS}/configuration.nix; in
configuration.${PACKAGE}.rev or \"master\"
"`

# Remove the quotes around the string
echo ${REVISION} | tr -d '"'
