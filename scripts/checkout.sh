#!/usr/bin/env bash
set -eu

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a package name}

REVISION=`   ${GALOIS}/scripts/get-revision.sh ${1}`
OWNER=`      ${GALOIS}/scripts/get-owner.sh ${1}`
PACKAGEPATH=`${GALOIS}/scripts/get-local-path.sh ${1}`
REMOTE=`     ${GALOIS}/scripts/get-remote.sh ${1}`

cd ${GALOIS}/projects

if [ ! -d "${REMOTE}" ]; then
    echo "Cloning package ${1} from remote ${OWNER}/${REMOTE}"
    if [ "${OWNER}" = "GaloisInc" ]; then
        git clone git@github.com:${OWNER}/${REMOTE}.git
    else
        git clone https://github.com/${OWNER}/${REMOTE}.git
    fi
fi
cd ${REMOTE}
echo "Checking out revision ${REVISION} for package ${1} from remote ${OWNER}/${REMOTE}"
git checkout ${REVISION}
echo "Navigating to ${PACKAGEPATH}"
cd ${PACKAGEPATH}
echo "Generating default.nix for revision ${REVISION} for package ${1} from remote ${OWNER}/${REMOTE}"
cabal2nix . > default.nix
