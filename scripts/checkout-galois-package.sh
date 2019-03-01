#!/usr/bin/env bash
set -euv

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a package name}

BRANCH=`     ${GALOIS}/scripts/get-branch-for-package.sh ${1}`
OWNER=`      ${GALOIS}/scripts/get-owner-for-package.sh ${1}`
PACKAGEPATH=`${GALOIS}/scripts/get-path-for-package.sh ${1}`
REMOTE=`     ${GALOIS}/scripts/get-remote-for-package.sh ${1}`

cd ${GALOIS}/galois-packages

if [ ! -d "${REMOTE}" ]; then
    echo "Cloning package ${1} from remote ${OWNER}/${REMOTE}"
    if [ "${OWNER}" = "GaloisInc" ]; then
        git clone git@github.com:${OWNER}/${REMOTE}.git
    else
        git clone https://github.com/${OWNER}/${REMOTE}.git
    fi
fi
cd ${REMOTE}
echo "Checking out branch ${BRANCH} for package ${1} from remote ${OWNER}/${REMOTE}"
git checkout ${BRANCH}
echo "Navigating to ${PACKAGEPATH}"
cd ${PACKAGEPATH}
echo "Generating default.nix for branch ${BRANCH} for package ${1} from remote ${OWNER}/${REMOTE}"
cabal2nix . > default.nix
