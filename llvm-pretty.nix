{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
haskellPackages.callCabal2nix "llvm-pretty" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "llvm-pretty";
  rev    = "4690fa103c6ce4d13fb659f0ac76b6c059157280";
  sha256 = "128ks93jpcxsas6g1qi091zxc25ijszd97is800ynfmf5fzgb958";
}) {}
