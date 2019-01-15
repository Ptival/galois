# This file assumes the existence of a directory
#   ./crucible/crucible/
# that comes from a checkout of:
#   https://github.com/GaloisInc/crucible
# and contains a file default.nix that can be obtained by running:
#   $ cabal2nix . > default.nix
# in said directory.
{ nixpkgs  ? import <nixpkgs> {}
, compiler ? "ghc844"
}:
with nixpkgs;
let
  what4 = callPackage ./what4.nix {};
in
haskell.packages.${compiler}.callPackage ./crucible/crucible/default.nix {
  inherit what4;
}
