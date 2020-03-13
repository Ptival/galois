{ nur ? (import ~/personal/nur-packages {})
# { nur ? (import <nixpkgs> {}).nur.repos.ptival
, nixpkgs ? import <nixpkgs> {}
# , nixpkgs ? import <nixpkgs> { overlays = [ nur.repos.ptival.overlays.PUMPKIN-PATCH ]; }
}:
with nixpkgs;
with nur;
mkShell {
  buildInputs = [
    (import ./abc.nix {})
    graphviz                # for dot
    sally
  ];
}
