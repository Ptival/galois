{ nixpkgs           ? import <nixpkgs> {}
, saw-nixpkgs       ? import ./projects/saw/nixpkgs.nix
, codescape-nixpkgs ? import ./projects/codescape/nixpkgs.nix
}:
with nixpkgs;
mkShell {
  buildInputs = [
    codescape-nixpkgs.codescape
    coq
    coqPackages.coq-extensible-records
    saw-nixpkgs.saw-core-coq
    saw-nixpkgs.saw-script
  ];
  name = "Galois";
}
