{ nur ? import ~/personal/nur-packages {}
# { nur ? (import <nixpkgs> {}).nur.repos.ptival
, nixpkgs ? import <nixpkgs> { overlays = [ nur.overlays.case ]; }
}:
with nixpkgs;
with nur;
let
  lustre-sally = nur.lib.callCabal2nixGitignore nixpkgs "lustre-sally" ./lustre-sally {};
in
mkShell {
  buildInputs = [
    abc
    graphviz # for dot
    lustre-sally
    sally
  ];
}
