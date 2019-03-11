#!/usr/bin/env bash
set -euv

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a package name}

OWNER=`${GALOIS}/scripts/get-owner-for-package.sh ${1}`
REMOTE=`${GALOIS}/scripts/get-remote-for-package.sh ${1}`
REVISION=`${GALOIS}/scripts/get-revision-for-package.sh ${1}`
# WARNING: don't rename this variable PATH as it means something to Linux!
MYPATH=`${GALOIS}/scripts/get-path-for-package.sh ${1}`

echo "Updating package ${1} from remote ${OWNER}/${REMOTE} to revision \"${REVISION}\""

(
    cd ${GALOIS}/galois-packages/revisions
    nix-prefetch-github ${OWNER} ${REMOTE} --rev ${REVISION} > ${1}.json
)

(
    cd ${GALOIS}/galois-packages/${REMOTE}
    git pull -r origin ${REVISION}
    cd ./${MYPATH}
    cabal2nix . > default.nix
)
