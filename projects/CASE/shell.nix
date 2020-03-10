{ nixpkgs ? import <nixpkgs> {}
}:
with nixpkgs;
mkShell {
  buildInputs = [
    (import ./abc.nix {})
    graphviz                # for dot
    (import ./sally.nix {})
  ];
}
