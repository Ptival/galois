{ nur ? import ~/personal/nur-packages {}
}:
let
  config = import ./config.nix {};
in
nur.lib.haskellDevShell {

  inherit (config) nixpkgsRev pkg;

  nixpkgsArgs = {
    overlays = [
      config.haskell-dev-overlay
      config.what4-overlay
    ];
  };

}
