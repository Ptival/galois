{ nur ? import ~/personal/nur-packages {}
}:
let
  crucible-config = import ./crucible/config.nix {};
in
nur.lib.stackShell {

  mkBuildInputs = pkgs: hsPkgs: [
    nur.abc
    pkgs.boost
    pkgs.glpk
    pkgs.ntl
    pkgs.zlib
    pkgs.z3
  ];

  inherit (crucible-config) ghcVersion nixpkgsRev pkg;

  nixpkgsArgs = {
    overlays = [
      crucible-config.crucible-overlay
    ];
  };

}
