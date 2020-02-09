{ nixpkgs ? import <nixpkgs> {}
}:
with nixpkgs;
mkShell {
  buildInputs = [
    coq
    coqPackages.coq-bits
    coqPackages.mathcomp
    (callPackage ./coq-extensible-records.nix {})
  ];
  name = "saw-core-coq-coq";
}
