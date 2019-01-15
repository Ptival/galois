let configuration = import ./configuration.nix; in
{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callCabal2nix "macaw-x86" ((fetchFromGitHub {
  inherit (configuration.macaw) rev sha256;
  owner = "GaloisInc";
  repo  = "macaw";
}) + "/x86") {}
