let configuration = import ./configuration.nix; in
{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskell.lib.dontCheck (
haskellPackages.callCabal2nix "macaw-x86-symbolic" ((fetchFromGitHub {
  inherit (configuration.macaw) rev sha256;
  owner = "GaloisInc";
  repo  = "macaw";
}) + "/x86_symbolic") {}
)
