{

  compiler = "ghc865";

  packages = rec {

    codescape = {
      local = true;
      path = "backend";
    };

    polysemy = {
      local = true;
      remote = {
        owner = "isovector";
        repo = "polysemy";
        rev = "f2ca91d57d02f8668d0204ec994a717b206e7575";
        sha256 = "0nvsgjjm0yjn02h4ykdqqvpm4d63avpfj4r5vj26d407ipkmr389";
      };
    };

    polysemy-plugin = {
      inherit (polysemy) local owner remote rev;
      path = "polysemy-plugin";
      wrapper = nixpkgs: drv: nixpkgs.haskell.lib.dontCheck drv;
    };

  };

}
