#!/usr/bin/env bash
set -eu

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a project name}
: ${2?First argument should be a package name}

PROJECT=$1
PACKAGE=$2

# Some packages names do not correspond to their repository name.  They should
# have a `remote` field in `configuration.nix` to point to the right repository.
REMOTE=`nix-instantiate --eval -E "
let
  configuration = import ${GALOIS}/projects/${PROJECT}/configuration.nix;
  utils         = import ${GALOIS}/utils.nix { projectConfiguration = configuration; };
in
utils.getPackageRemoteName \"${PACKAGE}\"
"`

# Remove the quotes around the string
echo ${REMOTE} | tr -d '"'
