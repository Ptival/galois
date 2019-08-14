#!/usr/bin/env bash
set -eu

: ${GALOIS?Need path to Galois directory in GALOIS environment variable}
: ${1?First argument should be a project name}
: ${2?First argument should be a package name}

PROJECT=$1
PACKAGE=$2

# WARNING: don't rename this variable PATH as it means something to Linux!
PACKAGEPATH=`${GALOIS}/scripts/get-local-path.sh ${1} ${2}`

echo "Generating default.nix for package ${1}/${2}"

(
    cd ${GALOIS}/projects/${PROJECT}/${PACKAGEPATH}
    cabal2nix . > default.nix
    # Replaces:
    #   src = ./.;
    # with something filtering out non-important paths
    # NOTE: you cannot just use fetchGit, because some projects live in git subdirectories,
    # which creates problems.
    sed -i -e 's~src = ./.~src = builtins.filterSource (path: type:\
       baseNameOf path != ".git"\
    \&\& baseNameOf path != ".codescape_store"\
    \&\& baseNameOf path != ".stack-work"\
    \&\& baseNameOf path != "dist"\
    \&\& baseNameOf path != "dist-newstyle"\
    \&\& baseNameOf path != "default.nix"\
    \&\& baseNameOf path != "result"\
    ) ./.~g' default.nix
)
