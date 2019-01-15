{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskell.lib.dontCheck (
haskell.lib.disableLibraryProfiling (
haskell.lib.disableCabalFlag (
haskell.lib.disableCabalFlag (
haskellPackages.callCabal2nix "llvm-verifier" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "llvm-verifier";
  rev    = "16600b3ddbe7cc32ed2eebae63f64b18cb78e5b0";
  sha256 = "0f24yfsb06c592y8ym33qlsic8rbyn8wyh92j9iw474l3hqs9pir";
}) {}
) "build-lss"
) "build-utils"
)
)
