{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
let
  binary-symbols = callPackage ./binary-symbols.nix {};
  elf-edit       = callPackage ./elf-edit.nix       {};
in
haskellPackages.callCabal2nix "flexdis86" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "flexdis86";
  rev    = "2ac3d616996885f93b66c870520381cb09e783ca";
  sha256 = "0vm9ygpw42sdv6khv2xm8jvkrzpg96cg5j456if88xbx3bysn5zx";
}) {
  inherit binary-symbols;
  inherit elf-edit;
}
