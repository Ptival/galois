selfNixPkgs: superNixPkgs:

let

  compiler = configuration.compiler;

  configuration = import ./configuration.nix;

  notBroken = drv: superNixPkgs.haskell.lib.overrideCabal drv (drv: { broken = false; });

  utils = import ../../utils.nix { projectConfiguration = configuration; };

in

{

  abc = superNixPkgs.callPackage ./abc.nix { nixpkgs = selfNixPkgs; };

  haskellPackages = selfNixPkgs.haskell.packages.${compiler}.extend (selfHaskellPkgs: superHaskellPkgs:
    let

      addBuildDepends = superNixPkgs.haskell.lib.addBuildDepends;
      dontCheck       = superNixPkgs.haskell.lib.dontCheck;
      dontHaddock     = superNixPkgs.haskell.lib.dontHaddock;

    in
    {

      # These packages exist but are modified by the overlay
      abcBridge             = utils.makePackage selfNixPkgs "saw" "abcBridge";
      # Current aeson does not build with ghc844 because it's missing `contravariant` dependency
      # cf. https://github.com/Nix./nixpkgs/issues/53620
      aeson                 = addBuildDepends superHaskellPkgs.aeson [ selfHaskellPkgs.contravariant ];
      # aeson                 = dontCheck (addBuildDepends selfHaskellPkgs.aeson_1_4_3_0 [ selfHaskellPkgs.contravariant ]); # because of th-abstraction
      # aeson                 = dontCheck (addBuildDepends selfHaskellPkgs.aeson_1_4_4_0 [ selfHaskellPkgs.contravariant ]); # because of th-abstraction
      aig                   = utils.makePackage selfNixPkgs "saw" "aig";
      # ansi-terminal         = selfHaskellPkgs.ansi-terminal_0_9_1;
      # contravariant         = selfHaskellPkgs.contravariant_1_5_2;
      cryptol               = notBroken superHaskellPkgs.cryptol;
      # cryptol               = utils.makePackage selfNixPkgs "saw" "cryptol";
      Diff                  = dontCheck superHaskellPkgs.Diff;
      ghc-lib-parser        = dontHaddock superHaskellPkgs.ghc-lib-parser;
      # hashable              = dontCheck superHaskellPkgs.hashable;
      # hspec-meta            = dontCheck superHaskellPkgs.hspec-meta;
      jvm-parser            = utils.makePackage selfNixPkgs "saw" "jvm-parser";
      llvm-pretty           = utils.makePackage selfNixPkgs "saw" "llvm-pretty";
      llvm-pretty-bc-parser = utils.makePackage selfNixPkgs "saw" "llvm-pretty-bc-parser";
      parameterized-utils   = utils.makePackage selfNixPkgs "saw" "parameterized-utils";
      # QuickCheck            = selfHaskellPkgs.QuickCheck_2_13_2;
      # quickcheck-instances  =
      #   addBuildDepends
      #     selfHaskellPkgs.quickcheck-instances_0_3_22
      #     [ selfHaskellPkgs.QuickCheck_2_13_2 ]; # cannot override QuickCheck itself as it creates a loop
      sbv                   = utils.makePackage selfNixPkgs "saw" "sbv";
      # tasty                 = selfHaskellPkgs.tasty_1_2_3;
      # th-abstraction        = selfHaskellPkgs.th-abstraction_0_3_1_0; # needed for llvm-pretty 0.10.3
      # th-lift               = selfHaskellPkgs.th-lift_0_8_0_1;        # because of th-abstraction
      # time-compat           = dontCheck selfHaskellPkgs.time-compat_1_9_2_2;
      z3                    = notBroken (dontCheck superHaskellPkgs.z3);

      # These packages don't pre-exist, they are added by the overlay
      binary-symbols     = utils.makePackage selfNixPkgs "saw" "binary-symbols";
      crucible           = utils.makePackage selfNixPkgs "saw" "crucible";
      crucible-jvm       = utils.makePackage selfNixPkgs "saw" "crucible-jvm";
      crucible-llvm      = utils.makePackage selfNixPkgs "saw" "crucible-llvm";
      crucible-saw       = utils.makePackage selfNixPkgs "saw" "crucible-saw";
      crux               = utils.makePackage selfNixPkgs "saw" "crux";
      cryptol-verifier   = utils.makePackage selfNixPkgs "saw" "cryptol-verifier";
      elf-edit           = utils.makePackage selfNixPkgs "saw" "elf-edit";
      flexdis86          = utils.makePackage selfNixPkgs "saw" "flexdis86";
      galois-dwarf       = utils.makePackage selfNixPkgs "saw" "galois-dwarf";
      jvm-verifier       = utils.makePackage selfNixPkgs "saw" "jvm-verifier";
      llvm-verifier      = utils.makePackage selfNixPkgs "saw" "llvm-verifier";
      macaw-base         = utils.makePackage selfNixPkgs "saw" "macaw-base";
      macaw-symbolic     = utils.makePackage selfNixPkgs "saw" "macaw-symbolic";
      macaw-x86          = utils.makePackage selfNixPkgs "saw" "macaw-x86";
      macaw-x86-symbolic = utils.makePackage selfNixPkgs "saw" "macaw-x86-symbolic";
      saw-core           = utils.makePackage selfNixPkgs "saw" "saw-core";
      saw-core-aig       = utils.makePackage selfNixPkgs "saw" "saw-core-aig";
      saw-core-coq       = utils.makePackage selfNixPkgs "saw" "saw-core-coq";
      saw-core-sbv       = utils.makePackage selfNixPkgs "saw" "saw-core-sbv";
      saw-core-what4     = utils.makePackage selfNixPkgs "saw" "saw-core-what4";
      saw-script         = utils.makePackage selfNixPkgs "saw" "saw-script";
      what4              = utils.makePackage selfNixPkgs "saw" "what4";

    });

}
