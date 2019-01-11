# This file assumes the existence of a directory
#   ./saw-core/
# that is a checkout of:
#   https://github.com/GaloisInc/saw-core
# and contains a file default.nix that can be obtained by running:
#   $ cabal2nix . > default.nix
# in said directory.
{ nixpkgs  ? import <nixpkgs> {}
, compiler ? "ghc844"
}:
nixpkgs.haskell.packages.${compiler}.callPackage ./saw-core/default.nix {}
