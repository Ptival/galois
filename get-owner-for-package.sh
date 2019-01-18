#!/usr/bin/env bash

PACKAGE=$1

OWNER=`nix-instantiate --eval -E "(import ./configuration.nix).${PACKAGE}.owner or \"GaloisInc\""`

# Remove the quotes around the string
echo ${OWNER} | tr -d '"'
