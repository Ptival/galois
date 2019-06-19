#!/usr/bin/env bash
set -eu

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a project name}
: ${2?First argument should be a package name}

PROJECT=$1
PACKAGE=$2

PACKAGEPATH=`nix-instantiate --eval -E "
let configuration = import ${GALOIS}/configuration.nix; in
configuration.getPackageLocalPath \"${PROJECT}\" \"${PACKAGE}\"
"`

# Remove the quotes around the string
echo ${PACKAGEPATH} | tr -d '"'
