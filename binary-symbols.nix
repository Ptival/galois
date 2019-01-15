{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callCabal2nix "binary-symbols" ((fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "flexdis86";
  rev    = "2ac3d616996885f93b66c870520381cb09e783ca";
  sha256 = "0vm9ygpw42sdv6khv2xm8jvkrzpg96cg5j456if88xbx3bysn5zx";
}) + "/binary-symbols") {}
