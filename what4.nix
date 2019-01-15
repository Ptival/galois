# This file assumes the existence of a directory
#   ./crucible/what4/
# that comes from a checkout of:
#   https://github.com/GaloisInc/crucible
# and contains a file default.nix that can be obtained by running:
#   $ cabal2nix . > default.nix
# in said directory.
{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
# NOTE: tests will fail unless you have z3 installed.
haskell.lib.dontCheck (
  haskell.packages.${compiler}.callPackage ./crucible/what4/default.nix {
    inherit (haskellPackages) parameterized-utils;
  }
)
