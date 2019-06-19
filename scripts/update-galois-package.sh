#!/usr/bin/env bash
set -eu

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a project name}
: ${2?First argument should be a package name}

PROJECT=$1
PACKAGE=$2

OWNER=`${GALOIS}/scripts/get-owner-for-package.sh ${1} ${2}`
REMOTE=`${GALOIS}/scripts/get-remote-for-package.sh ${1} ${2}`
# REVISION=`${GALOIS}/scripts/get-revision-for-package.sh ${1}`
# WARNING: don't rename this variable PATH as it means something to Linux!
MYPATH=`${GALOIS}/scripts/get-path-for-package.sh ${1} ${2}`

echo "Updating package ${1}/${2} from remote ${OWNER}/${REMOTE}" #" to revision \"${REVISION}\""

# (
#     cd ${GALOIS}/projects/revisions FIXME
#     nix-prefetch-github ${OWNER} ${REMOTE} --rev ${REVISION} > ${1}.json
# )

(
    # cd ${GALOIS}/projects/${REMOTE} FIXME
    # git pull -r origin ${REVISION}
    cd ${GALOIS}/projects/${PROJECT}/${MYPATH}
    cabal2nix . > default.nix
    # Replaces:
    #   src = ./.;
    # with something filtering out non-important paths
    # NOTE: you cannot just use fetchGit, because some projects live in git subdirectories,
    # which creates problems.
    sed -i '' -e 's~src = ./.~src = builtins.filterSource (path: type:\
       baseNameOf path != ".git"\
    \&\& baseNameOf path != ".stack-work"\
    \&\& baseNameOf path != "dist"\
    \&\& baseNameOf path != "dist-newstyle"\
    ) ./.~g' default.nix
)
