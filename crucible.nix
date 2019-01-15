{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callPackage ./crucible/crucible/default.nix {}
