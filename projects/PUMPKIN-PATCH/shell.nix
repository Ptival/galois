{ nixpkgs ? import ~/nixpkgs { overlays = [ (import ./overlay.nix) ]; }
}:
with nixpkgs;
mkShell {
  buildInputs = [
    coq
    coq.passthru.camlp5
    coq.passthru.findlib
    coq.passthru.ocaml
    coqPackages.coq-plugin-lib
    coqPackages.fix-to-elim
    coqPackages.ornamental-search
    coqPackages.PUMPKIN-PATCH
    coqPackages.ssreflect
  ];
  name = "PUMPKIN-PATCH";
}
