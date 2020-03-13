{ nixpkgs ?
    import
        <nixpkgs>
        { overlays = [ (import ~/personal/nur-packages/overlays).saw-script ];}
}:
with nixpkgs;
with (callPackage ../crucible.nix {});
mkShell {
    buildInputs = [
        haskellPackages.cabal-install
        clang
        ghc
    ];
    inputsFrom = [
        haskellPackages.crucible-jvm.env
    ];
    TARGET="exe:crucible-jvm";
}
