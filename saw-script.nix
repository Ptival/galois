{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callPackage ./saw-script/default.nix {}
