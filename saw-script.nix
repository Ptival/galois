# This file assumes the existence of a directory
#   ./saw-script/
# that is a checkout of:
#   https://github.com/GaloisInc/saw-script
# and contains a file default.nix that can be obtained by running:
#   $ cabal2nix . > default.nix
# in said directory.
{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
haskell.packages.${compiler}.callPackage ./saw-script/default.nix {
  # inherit crucible;
  # inherit crucible-jvm;
  # inherit crucible-llvm;
  # inherit crucible-saw;
  # inherit cryptol-verifier;
  # inherit elf-edit;
  # inherit flexdis86;
  # inherit jvm-verifier;
  # inherit llvm-verifier;
  # inherit macaw-base;
  # inherit macaw-symbolic;
  # inherit macaw-x86;
  # inherit macaw-x86-symbolic;
  # inherit saw-core;
  # inherit saw-core-aig;
  # inherit saw-core-coq;
  # inherit saw-core-sbv;
  # inherit saw-core-what4;
  # inherit what4;
}
