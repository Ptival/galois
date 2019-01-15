{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callCabal2nix "parameterized-utils" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "parameterized-utils";
  rev    = "fac47a2a783cd885bdabfce026a5e7880be11537";
  sha256 = "12xkvcr70qiz01gr4zj6sf5lpcpcwgij40wv586fvd9lgik1h0d8";
}) {}
