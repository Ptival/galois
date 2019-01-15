{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
haskellPackages.callCabal2nix "saw-core-sbv" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "saw-core-sbv";
  rev    = "5b2fe36934b0688251774971552371d186d5e56e";
  sha256 = "05xaf5a80p9pwl4nhz1s9xqcgb8d5sp9y14sr4rpr2hyd69m63qx";
}) {
  inherit saw-core;
}
