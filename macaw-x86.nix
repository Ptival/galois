{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
haskellPackages.callCabal2nix "macaw-x86" ((fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "macaw";
  rev    = "b398db41b22808d55d16492d6a8d588d037e7389";
  sha256 = "0g7mr8sjgii36laq8qpgwcgj8ckip545b87i4kb7l8njyssk0ffz";
  # rev    = "190ed0712115559774c7c0d86833c6becd949fe2";
  # sha256 = "187l803swk6313dgcvn8n2sd6sjmi5zm9vpc6yzf46byaf8ziax9";
}) + "/x86") {}
