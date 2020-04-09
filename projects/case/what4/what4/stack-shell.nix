{ nur ? import ~/personal/nur-packages {}
}:
let
  config = import ./config.nix {};
in
nur.lib.stackShell {

  mkBuildInputs = pkgs: hsPkgs: [
    pkgs.zlib
  ];

  inherit (config) ghcVersion nixpkgsRev pkg;

  nixpkgsArgs = {
    overlays = [
      config.what4-overlay
    ];
  };

}
