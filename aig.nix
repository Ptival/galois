{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
haskellPackages.callCabal2nix "aig" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "aig";
  rev    = "9c6f67ac66cb947577cd4ded494fef10c2a1b2fa";
  sha256 = "1wzzshdpxndfvaip93a3slsnmiiw74h754ap7x28am4lfygf34gx";
}) {}
