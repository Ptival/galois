{ nur ? import ~/personal/nur-packages {}
}:
rec {

  ghcVersion = "ghc865";

  language-sally-overlay = self: super:
    let

      dontCheck = super.haskell.lib.dontCheck;

    in
      {
        haskell = super.haskell // {
          inherit ghcVersion;
          packages = super.haskell.packages // {
            "${ghcVersion}" = super.haskell.packages.${ghcVersion}.extend (selfH: superH: {

              # Currently, language-sally does not need any override

            });
          };
        };
      };

  nixpkgsRev = "c2dcdea8c68631fc15ec837d0df7def2b66d0676";

  pkg = {
    name = "language-sally";
    path = ./.;
    args = {};
  };

}
