{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskellPackages.callPackage ./saw-core-what4/default.nix {}
# haskellPackages.callCabal2nix "saw-core-what4" (fetchFromGitHub {
#   owner  = "GaloisInc";
#   repo   = "saw-core-what4";
#   rev    = "8a52bf9cb8ce42f5a34e9aab4880a2d92e932132";
#   sha256 = "0qasmpw8fqppcbfwg8ar8n00hsp61wnsln28cgh0f8zva0gy6b82";
# }) {}
