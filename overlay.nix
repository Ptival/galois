let configuration = import ./configuration.nix; in
{ compiler ? configuration.compiler
}:
selfNixPkgs: superNixPkgs:
let
  nixpkgs = selfNixPkgs; # just so that we can write "inherit nixpkgs;"
in
{
  abc                = superNixPkgs.callPackage ./abc.nix                { inherit nixpkgs; };
  binary-symbols     = superNixPkgs.callPackage ./binary-symbols.nix     { inherit nixpkgs; };
  crucible           = superNixPkgs.callPackage ./crucible.nix           { inherit nixpkgs; };
  crucible-jvm       = superNixPkgs.callPackage ./crucible-jvm.nix       { inherit nixpkgs; };
  crucible-llvm      = superNixPkgs.callPackage ./crucible-llvm.nix      { inherit nixpkgs; };
  crucible-saw       = superNixPkgs.callPackage ./crucible-saw.nix       { inherit nixpkgs; };
  crux               = superNixPkgs.callPackage ./crux.nix               { inherit nixpkgs; };
  cryptol-verifier   = superNixPkgs.callPackage ./cryptol-verifier.nix   { inherit nixpkgs; };
  elf-edit           = superNixPkgs.callPackage ./elf-edit.nix           { inherit nixpkgs; };
  flexdis86          = superNixPkgs.callPackage ./flexdis86.nix          { inherit nixpkgs; };
  galois-dwarf       = superNixPkgs.callPackage ./galois-dwarf.nix       { inherit nixpkgs; };
  jvm-verifier       = superNixPkgs.callPackage ./jvm-verifier.nix       { inherit nixpkgs; };
  llvm-verifier      = superNixPkgs.callPackage ./llvm-verifier.nix      { inherit nixpkgs; };
  macaw-base         = superNixPkgs.callPackage ./macaw-base.nix         { inherit nixpkgs; };
  macaw-symbolic     = superNixPkgs.callPackage ./macaw-symbolic.nix     { inherit nixpkgs; };
  macaw-x86          = superNixPkgs.callPackage ./macaw-x86.nix          { inherit nixpkgs; };
  macaw-x86-symbolic = superNixPkgs.callPackage ./macaw-x86-symbolic.nix { inherit nixpkgs; };
  saw-core           = superNixPkgs.callPackage ./saw-core.nix           { inherit nixpkgs; };
  saw-core-aig       = superNixPkgs.callPackage ./saw-core-aig.nix       { inherit nixpkgs; };
  saw-core-coq       = superNixPkgs.callPackage ./saw-core-coq.nix       { inherit nixpkgs; };
  saw-core-sbv       = superNixPkgs.callPackage ./saw-core-sbv.nix       { inherit nixpkgs; };
  saw-core-what4     = superNixPkgs.callPackage ./saw-core-what4.nix     { inherit nixpkgs; };
  saw-script         = superNixPkgs.callPackage ./saw-script.nix         { inherit nixpkgs; };
  what4              = superNixPkgs.callPackage ./what4.nix              { inherit nixpkgs; };

  haskellPackages = nixpkgs.haskell.packages.${compiler}.extend (selfHaskellPkgs: superHaskellPkgs: {
    abcBridge             = superHaskellPkgs.callPackage ./abcBridge.nix             { inherit nixpkgs; };
    aig                   = superHaskellPkgs.callPackage ./aig.nix                   { inherit nixpkgs; };
    cryptol               = superHaskellPkgs.callPackage ./cryptol.nix               { inherit nixpkgs; };
    jvm-parser            = superHaskellPkgs.callPackage ./jvm-parser.nix            { inherit nixpkgs; };
    llvm-pretty           = superHaskellPkgs.callPackage ./llvm-pretty.nix           { inherit nixpkgs; };
    llvm-pretty-bc-parser = superHaskellPkgs.callPackage ./llvm-pretty-bc-parser.nix { inherit nixpkgs; };
    parameterized-utils   = superHaskellPkgs.callPackage ./parameterized-utils.nix   { inherit nixpkgs; };
  });
}
