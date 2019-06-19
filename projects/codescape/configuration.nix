{

  compiler = "ghc865";

  packages = rec {

    codescape = {
      local = true;
      path = "backend";
    };

    polysemy = {
      local = true;
      owner = "isovector";
      remote = "polysemy";
      rev = "c937132caa43bbd4e2360e50e5de5b39cc0ceb24";
    };

    polysemy-plugin = {
      inherit (polysemy) local owner remote rev;
      path = "polysemy-plugin";
      wrapper = nixpkgs: drv: nixpkgs.haskell.lib.dontCheck drv;
    };

  };

}
