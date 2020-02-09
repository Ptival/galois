{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
mkShell {
  buildInputs = [
    cabal-install
    ghc
    hlint
    nixpkgs.abc
    #stack
    zlib
  ];
  inputsFrom = [
    #(import ./abcBridge.nix {}).env
    #(import ./cryptol-verifier.nix {}).env
  ];
  name="saw";
}


# haskellPackages.shellFor {
#   buildInputs = [
#     (callPackage ./abc.nix {})
#     stack
#   ];
#   name = "saw";
#   packages = p: [
#     p.abcBridge # need this so that libabc is present
#   ];
# }
