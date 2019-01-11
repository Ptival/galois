# This file assumes the existence of a directory
#   ./saw-core-coq/
# that is a checkout of:
#   https://github.com/GaloisInc/saw-core-coq
# and contains a file default.nix that can be obtained by running:
#   $ cabal2nix . > default.nix
# in said directory.
{ nixpkgs  ? import <nixpkgs> {}
, compiler ? "ghc844"
}:
let
  saw-core = nixpkgs.callPackage ./saw-core.nix { inherit nixpkgs compiler; };
in
nixpkgs.haskell.packages.${compiler}.callPackage
  ./saw-core-coq/default.nix
  { inherit saw-core; }
