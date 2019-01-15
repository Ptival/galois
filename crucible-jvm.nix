# This file assumes the existence of a directory
#   ./crucible/crucible-jvm/
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
  crucible   = callPackage ./crucible.nix   {};
  crux       = callPackage ./crux.nix       {};
  # NOTE: the version of jvm-parser on Hackage does not build
  jvm-parser = callPackage ./jvm-parser.nix {};
  what4      = callPackage ./what4.nix      {};
in
haskell.packages.${compiler}.callPackage ./crucible/crucible-jvm/default.nix {
  inherit crucible;
  inherit crux;
  inherit jvm-parser;
  inherit what4;
}
