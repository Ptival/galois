{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
let
  configuration = import ./configuration.nix;
in
haskellPackages.callCabal2nix "macaw-base" ((fetchFromGitHub {
  inherit (configuration.macaw) rev sha256;
  owner = "GaloisInc";
  repo  = "macaw";
}) + "/base") {}
