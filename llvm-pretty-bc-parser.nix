{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskell.lib.dontCheck (
haskellPackages.callCabal2nix "llvm-pretty-bc-parser" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "llvm-pretty-bc-parser";
  rev    = "181713af59587ae61b4f4625407cc5e795b8c70b";
  sha256 = "1whd8fgihn9rrfcl1fpg5rxy6a8lm897hddisgwymldzg5x3a36x";
}) {}
)
