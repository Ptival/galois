{ compiler ? (import ./configuration.nix).compiler
}:
selfNixPkgs: superNixPkgs:
let
  nixpkgs = selfNixPkgs;
in
{
  # NOTE: the commented out packages do not build on my machine
  binary-symbols     = superNixPkgs.callPackage ./binary-symbols.nix     { inherit nixpkgs compiler; };
  crucible           = superNixPkgs.callPackage ./crucible.nix           { inherit nixpkgs compiler; };
  crucible-jvm       = superNixPkgs.callPackage ./crucible-jvm.nix       { inherit nixpkgs compiler; };
  crucible-llvm      = superNixPkgs.callPackage ./crucible-llvm.nix      { inherit nixpkgs compiler; };
  crucible-saw       = superNixPkgs.callPackage ./crucible-saw.nix       { inherit nixpkgs compiler; };
  # cryptol-verifier   = superNixPkgs.callPackage ./cryptol-verifier.nix   { inherit nixpkgs compiler; };
  elf-edit           = superNixPkgs.callPackage ./elf-edit.nix           { inherit nixpkgs compiler; };
  flexdis86          = superNixPkgs.callPackage ./flexdis86.nix          { inherit nixpkgs compiler; };
  galois-dwarf       = superNixPkgs.callPackage ./galois-dwarf.nix       { inherit nixpkgs compiler; };
  # jvm-verifier       = superNixPkgs.callPackage ./jvm-verifier.nix       { inherit nixpkgs compiler; };
  # llvm-verifier      = superNixPkgs.callPackage ./llvm-verifier.nix      { inherit nixpkgs compiler; };
  macaw-base         = superNixPkgs.callPackage ./macaw-base.nix         { inherit nixpkgs compiler; };
  macaw-symbolic     = superNixPkgs.callPackage ./macaw-symbolic.nix     { inherit nixpkgs compiler; };
  macaw-x86          = superNixPkgs.callPackage ./macaw-x86.nix          { inherit nixpkgs compiler; };
  # macaw-x86-symbolic = superNixPkgs.callPackage ./macaw-x86-symbolic.nix { inherit nixpkgs compiler; };
  saw-core           = superNixPkgs.callPackage ./saw-core.nix           { inherit nixpkgs compiler; };
  saw-core-aig       = superNixPkgs.callPackage ./saw-core-aig.nix       { inherit nixpkgs compiler; };
  saw-core-coq       = superNixPkgs.callPackage ./saw-core-coq.nix       { inherit nixpkgs compiler; };
  saw-core-sbv       = superNixPkgs.callPackage ./saw-core-sbv.nix       { inherit nixpkgs compiler; };
  saw-core-what4     = superNixPkgs.callPackage ./saw-core-what4.nix     { inherit nixpkgs compiler; };
  what4              = superNixPkgs.callPackage ./what4.nix              { inherit nixpkgs compiler; };

  haskellPackages = nixpkgs.haskell.packages.${compiler}.extend (selfHaskellPkgs: superHaskellPkgs: {
    abcBridge             = superHaskellPkgs.callPackage ./abcBridge.nix             { inherit nixpkgs compiler; };
    aig                   = superHaskellPkgs.callPackage ./aig.nix                   { inherit nixpkgs compiler; };
    cryptol               = superHaskellPkgs.callPackage ./cryptol.nix               { inherit nixpkgs compiler; };
    llvm-pretty           = superHaskellPkgs.callPackage ./llvm-pretty.nix           { inherit nixpkgs compiler; };
    llvm-pretty-bc-parser = superHaskellPkgs.callPackage ./llvm-pretty-bc-parser.nix { inherit nixpkgs compiler; };
    parameterized-utils   = superHaskellPkgs.callPackage ./parameterized-utils.nix   { inherit nixpkgs compiler; };
  });

  # haskell.packages.${compiler}.callPackage = haskell.packages.${compiler}.callPackagesWith
}
