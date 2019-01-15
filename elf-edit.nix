{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callCabal2nix "elf-edit" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "elf-edit";
  rev    = "a9428d847f63cddfbd38eb3b0fea07153dbcd18f";
  sha256 = "0h0w6apsygx9w95rx86rlgaq5jjavkz5skvfqbb80jwz01ph9i81";
}) {}
