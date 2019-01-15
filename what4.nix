{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
# NOTE: tests will fail unless you have z3 installed.
haskell.lib.dontCheck (
  haskellPackages.callPackage ./crucible/what4/default.nix {}
)
