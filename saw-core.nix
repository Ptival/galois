{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callPackage ./saw-core/default.nix {}
