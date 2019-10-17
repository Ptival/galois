#!/usr/bin/env bash
set -eu

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a project name}
: ${2?First argument should be a package name}

PROJECT=$1
PACKAGE=$2

# WARNING: don't rename this variable PATH as it means something to Linux!
PACKAGEPATH=`${GALOIS}/scripts/get-local-path.sh ${1} ${2}`
REVISION=`   ${GALOIS}/scripts/get-revision.sh   ${1} ${2}`

echo "Updating package ${1}/${2} from remote ${OWNER}/${REMOTE} to revision \"${REVISION}\""

(
    mkdir -p ${GALOIS}/projects/${PROJECT}/revisions
    cd ${GALOIS}/projects/${PROJECT}/revisions
    nix-prefetch-github ${OWNER} ${REMOTE} --rev ${REVISION} > ${1}.json
)
