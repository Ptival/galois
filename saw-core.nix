# This file assumes the existence of a directory
#   ./saw-core/
# that is a checkout of:
#   https://github.com/GaloisInc/saw-core
# and contains a file default.nix that can be obtained by running:
#   $ cabal2nix . > default.nix
# in said directory.
{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
haskell.packages.${compiler}.callPackage ./saw-core/default.nix {
  inherit (haskellPackages) parameterized-utils;
}
