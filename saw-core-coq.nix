let configuration = import ./configuration.nix; in
{ nixpkgs ? import ./nixpkgs.nix
, local   ? configuration.saw-core-coq.local
}:
with nixpkgs;
if local
then
haskellPackages.callPackage ./saw-core-coq/default.nix {}
else
haskellPackages.callCabal2nix "saw-core-coq" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "saw-core-coq";
  rev    = "9e60c1d6e44958124dc7eeb209e6a0a99f71e2c7";
  sha256 = "0qdjn3m6mjhkk4g6s3hldqjjsfzxwwbphn5fwb7sb4yzxr8xhl5h";
}) {}
