let configuration = import ./configuration.nix; in
{ nixpkgs ? import ./nixpkgs.nix
, local   ? configuration.cryptol-verifier.local
}:
with nixpkgs;
if local
then
haskell.lib.disableCabalFlag (
haskellPackages.callPackage ./cryptol-verifier/default.nix {}
) "build-css"
else
# NOTE: To build executable `css`, it seems `g++` as well as some libraries are
# needed
haskell.lib.overrideCabal (
haskellPackages.callCabal2nix "cryptol-verifier" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "cryptol-verifier";
  rev    = "892365d1f152de0d5c5b4f577e5916667f45b895";
  sha256 = "00dypcn7nlkailqqarrqi70ficbs451j9iznaaawaf8asv4lsa1n";
}) {}
) (old: {
  buildDepends = (old.buildDepends or []) ++ [ libiconv llvmPackages.libstdcxxClang ] ++ "${stdenv.cc.cc.lib}";
  buildTools = (old.buildTools or []) ++ [ clang ];
  # isExecutable = false;
  preBuild = ''
    export buildFlags="CC=$CC CXX=$CXX LD=$CXX"
  '';
})
