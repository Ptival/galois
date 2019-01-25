#!/usr/bin/env bash

OWNER=`./get-owner-for-package.sh ${1}`
REMOTE=`./get-remote-for-package.sh ${1}`

echo "Updating package ${1} from remote ${OWNER}/${REMOTE}"

(
    cd galois-packages/revisions
    nix-prefetch-github ${OWNER} ${REMOTE} > ${1}.json
)

(
    cd galois-packages/${REMOTE}
    git pull -r
)
