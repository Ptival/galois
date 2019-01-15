{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callCabal2nix "saw-core-aig" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "saw-core-aig";
  rev    = "a9d971d1f4f3a0dcbbdf15a77d00fcc4d82183ea";
  sha256 = "0yw0xidgqs4j306rl4hmrjs2f4rgidbijh2s4zj4xmlxxanb1z43";
}) {}
