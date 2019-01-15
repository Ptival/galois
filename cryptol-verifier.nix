{ compiler ? (import ./configuration.nix).compiler
, nixpkgs  ? import <nixpkgs> { overlays = [(import ./overlay.nix { inherit compiler; })]; }
}:
with nixpkgs;
# NOTE: To build executable `css`, it seems `g++` as well as some libraries are
# needed
haskell.lib.overrideCabal (
haskellPackages.callCabal2nix "cryptol-verifier" (fetchFromGitHub {
  owner  = "GaloisInc";
  repo   = "cryptol-verifier";
  rev    = "5423daf6a9ec2b5942599051ca3b858810c306aa";
  sha256 = "00dypcn7nlkailqqarrqi70ficbs451j9iznvvawaf8asv4lsa1n";
  # rev    = "892365d1f152de0d5c5b4f577e5916667f45b895";
  # sha256 = "0ny14ynqp9xd9zydf0l3jrj8sn53rqsjcam4pzbdwzjhnj546kpf";
}) {
  inherit (haskellPackages) abcBridge;
  inherit (haskellPackages) cryptol;
  inherit saw-core;
  inherit saw-core-aig;
  inherit saw-core-sbv;
  inherit saw-core-what4;
  inherit what4;
}
) (old: {
  buildDepends = (old.buildDepends or []) ++ [ libiconv ];
  # buildTools = (old.buildTools or []) ++ [ gcc ];
  isExecutable = false;
  # preBuild = ''
  #   export buildFlags="CC=$CC CXX=$CXX LD=$CXX"
  # '';
})
