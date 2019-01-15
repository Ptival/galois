{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
let
  abc = callPackage ./abc.nix {};
in
haskell.lib.dontCheck (
(haskell.packages.${compiler}.callPackage ./abcBridge/default.nix {
  inherit abc;
  inherit (haskellPackages) aig;
}).overrideDerivation (oldAttrs: {
  buildPhase = ''
    export NIX_CFLAGS_COMPILE+=" -I${abc}/include"
    export NIX_LDFLAGS+=" -L${abc} -L${abc}/lib"
    ${oldAttrs.buildPhase}
  '';
})
)
# haskellPackages.callCabal2nix "abcBridge" (fetchFromGitHub {
#   deepClone       = true;
#   fetchSubmodules = true;
#   owner           = "GaloisInc";
#   repo            = "abcBridge";
#   rev             = "e5b6ddc63349c8b676771be672a40521f63aa8b3";
#   sha256          = "0nx4ff5j2vycy4x7bb5aks36jvafhdai1awa77a5bjqmhxzhnd58";
# }) {
#   inherit abc;
# }
