{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
mkShell {
  buildInputs = [
    codescape
    saw-core-coq
    saw-script
  ];
}
