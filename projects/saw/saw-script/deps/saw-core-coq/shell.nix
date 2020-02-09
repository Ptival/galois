{ nixpkgs ? import ../../../nixpkgs.nix
}:
with nixpkgs;
mkShell {
  buildInputs = [
    cabal-install
  ];
  inputsFrom = [
    haskellPackages.saw-core-coq.env
  ];
  name = "saw-core-coq";
}
