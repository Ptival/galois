#!/usr/bin/env bash

PACKAGE=$1

BRANCH=`nix-instantiate --eval -E "(import ./configuration.nix).${PACKAGE}.branch or \"master\""`

# Remove the quotes around the string
echo ${BRANCH} | tr -d '"'
