{ nur     ? import ~/personal/nur-packages {}
, nixpkgs ? import <nixpkgs> {}
}:
let
  config = import ./config.nix {};
in
nur.lib.stackShell {

  mkBuildInputs = pkgs: hsPkgs: [
    pkgs.zlib
  ];

  inherit (config) nixpkgsRev pkg;

  nixpkgsArgs = {
    overlays = [
      config.haskell-dev-overlay
      config.what4-overlay
    ];
  };

}
