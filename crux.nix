{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callPackage ./crucible/crux/default.nix {}
