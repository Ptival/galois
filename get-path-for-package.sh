#!/usr/bin/env bash

PACKAGE=$1

PACKAGEPATH=`nix-instantiate --eval -E "(import ./configuration.nix).${PACKAGE}.path or \".\""`

# Remove the quotes around the string
echo ${PACKAGEPATH} | tr -d '"'
