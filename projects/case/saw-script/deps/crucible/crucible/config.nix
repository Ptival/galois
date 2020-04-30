{ nur ? import ~/personal/nur-packages {}
}:
rec {

  ghcVersion = "ghc865";

  crucible-overlay = self: super:
    let

      dontCheck = super.haskell.lib.dontCheck;

      haskellOverlay = selfH: superH: {
          language-sally = self.haskellPackages.callCabal2nix "language-sally" ../dependencies/language-sally {};
          what4 = dontCheck (self.haskellPackages.callCabal2nix "what4" ../dependencies/what4/what4 {});
      };

    in
      {
        # cf. https://github.com/NixOS/nixpkgs/issues/83098
        # We need cabal2nix to depend on a different GHC to avoid infinite recursion
        # Last revision to not have the bug, if needed:
        #   nixpkgsRev = "c2dcdea8c68631fc15ec837d0df7def2b66d0676";
        cabal2nix-unwrapped = super.haskell.lib.justStaticExecutables (
          super.haskell.lib.generateOptparseApplicativeCompletion
            "cabal2nix"
            super.haskell.packages.ghc882.cabal2nix
        );
        haskellPackages = super.haskellPackages.extend haskellOverlay;
        haskell = super.haskell // {
          packages = super.haskell.packages // {
            "${ghcVersion}" =
              super.haskell.packages.${ghcVersion}.extend
                haskellOverlay;
          };
        };
      };

  nixpkgsRev = "b55652e20cc015ceb87b051ccda7ad259eb1f78d";

  pkg = {
    name = "crucible";
    path = ./.;
    args = {};
  };

}
