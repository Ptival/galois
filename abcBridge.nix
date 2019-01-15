let configuration = import ./configuration.nix; in
{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
haskell.lib.dontCheck (
(
haskellPackages.callPackage ./abcBridge/default.nix {}
).overrideDerivation (oldAttrs: {
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
# }) {}
