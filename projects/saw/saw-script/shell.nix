{ nixpkgs ? import ../nixpkgs.nix
}:
with nixpkgs;
mkShell {
  buildInputs = [
    cabal-install
  ];
  inputsFrom = [
    haskellPackages.saw-script.env
  ];
  name = "saw-script";
}
