{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
haskellPackages.callCabal2nix "llvm-verifier" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "llvm-verifier";
  rev    = "16600b3ddbe7cc32ed2eebae63f64b18cb78e5b0";
  sha256 = "0f24yfsb06c592y8ym33qlsic8rbyn8wyh92j9iw474l3hqs9pir";
}) {
  inherit (haskellPackages) abcBridge;
  inherit (haskellPackages) cryptol-verifier;
  inherit (haskellPackages) llvm-pretty;
  inherit (haskellPackages) saw-core;
  inherit (haskellPackages) saw-core-aig;
  inherit (haskellPackages) saw-core-sbv;
}
