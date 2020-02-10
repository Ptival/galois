{ nur ? (import <nixpkgs> {}).nur
, nixpkgs ? import <nixpkgs> { overlays = [ nur.repos.ptival.overlays.PUMPKIN-PATCH ]; }
}:
with nixpkgs;
mkShell {
  buildInputs = [
    coq
    coqPackages.coq-bits
    coqPackages.coq-extensible-records
    coqPackages.fix-to-elim
    coqPackages.mathcomp
    coqPackages.ornamental-search
  ];
  name = "saw-core-coq-coq";
}
