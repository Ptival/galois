{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callCabal2nix "galois-dwarf" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "dwarf";
  rev    = "9f9e04eddca691f5d0b838ec2d850b343fbbd115";
  sha256 = "0z8fjnxc9qjzpgsyrbbhp7dh3cai7zvni2iz46y0ra747vp476k8";
}) {}
