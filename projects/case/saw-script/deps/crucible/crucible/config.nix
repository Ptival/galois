{ nur ? import ~/personal/nur-packages {}
}:
rec {

  ghcVersion = "ghc865";

  crucible-overlay = self: super:
    let

      dontCheck = super.haskell.lib.dontCheck;

      haskellOverlay = selfH: superH: {
          what4 = dontCheck (self.haskellPackages.callCabal2nix "what4" ../dependencies/what4/what4 {});
      };

    in
      {
        haskellPackages = super.haskellPackages.extend haskellOverlay;
        haskell = super.haskell // {
          packages = super.haskell.packages // {
            "${ghcVersion}" =
              super.haskell.packages.${ghcVersion}.extend
                haskellOverlay;
          };
        };
      };

  nixpkgsRev = "c2dcdea8c68631fc15ec837d0df7def2b66d0676";

  pkg = {
    name = "crucible";
    path = ./.;
    args = {};
  };

}
