let configuration = import ./configuration.nix; in
{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callCabal2nix "macaw-base" ((fetchFromGitHub {
  inherit (configuration.macaw) rev sha256;
  owner = "GaloisInc";
  repo  = "macaw";
}) + "/base") {}
