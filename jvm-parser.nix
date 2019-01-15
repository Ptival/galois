{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callCabal2nix "jvm-parser" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "jvm-parser";
  rev    = "f37d40201271e3fa3ece8aa8346f87e4b211c82f";
  sha256 = "19qg3zf4gn0lc2gl2gggjd6d033bddvpy80kkzv8msbijrhppg6i";
}) {}
