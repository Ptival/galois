{ nixpkgs ?
    import
        <nixpkgs>
        { overlays = [ (import ~/personal/nur-packages/overlays).saw-script ];}
}:
with nixpkgs;
let
  dontCheck = haskell.lib.dontCheck;
in
{
  haskellPackages = nixpkgs.haskellPackages.extend (selfHaskell: superHaskell: rec {
    aig                   =            selfHaskell.callCabal2nix "" ./dependencies/aig                   { };
    crucible              =            selfHaskell.callCabal2nix "" ./crucible                           { };
    crucible-jvm          =            selfHaskell.callCabal2nix "" ./crucible-jvm                       { };
    crucible-llvm         = dontCheck (selfHaskell.callCabal2nix "" ./crucible-llvm                      { });
    crucible-mc           = dontCheck (selfHaskell.callCabal2nix "" ./crucible-mc                        { });
    crucible-saw          =            selfHaskell.callCabal2nix "" ./crucible-saw                       { };
    crucible-server       =            selfHaskell.callCabal2nix "" ./crucible-server                    { };
    crucible-syntax       =            selfHaskell.callCabal2nix "" ./crucible-syntax                    { };
    crux                  =            selfHaskell.callCabal2nix "" ./crux                               { };
    crux-llvm             = dontCheck (selfHaskell.callCabal2nix "" ./crux-llvm                          { });
    cryptol-verifier      =            selfHaskell.callCabal2nix "" ./dependencies/cryptol-verifier      { };
    hpb                   =            selfHaskell.callCabal2nix "" ./dependencies/hpb                   { };
    jvm-parser            =            selfHaskell.callCabal2nix "" ./dependencies/jvm-parser            { };
    llvm-pretty           =            selfHaskell.callCabal2nix "" ./dependencies/llvm-pretty           { };
    llvm-pretty-bc-parser = dontCheck (selfHaskell.callCabal2nix "" ./dependencies/llvm-pretty-bc-parser { });
    parameterized-utils   =            selfHaskell.callCabal2nix "" ./dependencies/parameterized-utils   { };
    saw-core              =            selfHaskell.callCabal2nix "" ./dependencies/saw-core              { };
    saw-core-aig          =            selfHaskell.callCabal2nix "" ./dependencies/saw-core-aig          { };
    saw-core-sbv          =            selfHaskell.callCabal2nix "" ./dependencies/saw-core-sbv          { };
    saw-core-what4        =            selfHaskell.callCabal2nix "" ./dependencies/saw-core-what4        { };
    what4                 = dontCheck (selfHaskell.callCabal2nix "" ./dependencies/what4/what4           { });
    what4-abc             =            selfHaskell.callCabal2nix "" ./dependencies/what4/what4-abc       { };
  });
}
