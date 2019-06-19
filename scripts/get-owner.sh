#!/usr/bin/env bash
set -eu

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a project name}
: ${2?First argument should be a package name}

PROJECT=$1
PACKAGE=$2

OWNER=`nix-instantiate --eval -E "
let configuration = import ${GALOIS}/projects/${PROJECT}/configuration.nix; in
configuration.${PACKAGE}.owner or \"GaloisInc\"
"`

# Remove the quotes around the string
echo ${OWNER} | tr -d '"'
