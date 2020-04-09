{ nur ? import ~/personal/nur-packages {}
}:
rec {

  ghcVersion = "ghc865";

  what4-overlay = self: super:
    let

      dontCheck = super.haskell.lib.dontCheck;

    in
      {
        haskell = super.haskell // {
          inherit ghcVersion;
          packages = super.haskell.packages // {
            "${ghcVersion}" = super.haskell.packages.${ghcVersion}.extend (selfH: superH: {

              # Currently, what4 does not need any override

            });
          };
        };
      };

  nixpkgsRev = "c2dcdea8c68631fc15ec837d0df7def2b66d0676";

  pkg = {
    name = "what4";
    path = ./.;
    args = {};
  };

}
