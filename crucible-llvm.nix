# This file assumes the existence of a directory
#   ./crucible/crucible-llvm/
# that comes from a checkout of:
#   https://github.com/GaloisInc/crucible
# and contains a file default.nix that can be obtained by running:
#   $ cabal2nix . > default.nix
# in said directory.
{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
haskell.packages.${compiler}.callPackage ./crucible/crucible-llvm/default.nix {
  inherit (haskellPackages) llvm-pretty;
  inherit (haskellPackages) llvm-pretty-bc-parser;
}
