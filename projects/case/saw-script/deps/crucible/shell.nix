{ nur ? import ~/personal/nur-packages {}
}:
let
  crucible-config = import ./crucible/config.nix {};
  haskell-dev-overlay = nur.overlays.haskell-dev.${crucible-config.ghcVersion};
in
nur.lib.haskellDevShell {

  addBuildInputs = pkgs: [
    pkgs.clang
  ];

  inherit (crucible-config) ghcVersion nixpkgsRev pkg;

  nixpkgsArgs = {
    overlays = [
      haskell-dev-overlay
      crucible-config.crucible-overlay
    ];
  };

}
