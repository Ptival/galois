selfNixPkgs: superNixPkgs:

let

  compiler = configuration.compiler;

  configuration = import ./configuration.nix;

  notBroken = drv: superNixPkgs.haskell.lib.overrideCabal drv (drv: { broken = false; });

  utils = import ../../utils.nix { projectConfiguration = configuration; };

in

{

  codescape = utils.makePackage selfNixPkgs "codescape" "codescape";

  haskellPackages = selfNixPkgs.haskell.packages.${compiler}.extend (selfHaskellPkgs: superHaskellPkgs: {

    aeson              = superNixPkgs.haskell.lib.addBuildDepends selfHaskellPkgs.aeson_1_4_3_0 [ selfHaskellPkgs.contravariant ];
    hpack              = superNixPkgs.haskell.lib.dontCheck superHaskellPkgs.hpack;
    polysemy           = utils.makePackage selfNixPkgs "codescape" "polysemy";
    polysemy-plugin    = utils.makePackage selfNixPkgs "codescape" "polysemy-plugin";
    th-abstraction     = selfHaskellPkgs.th-abstraction_0_3_1_0; # needed for llvm-pretty 0.10.3
    th-lift            = selfHaskellPkgs.th-lift_0_8_0_1;        # because of th-abstraction
    # Tests require hspec, skip them
    versioning         = superNixPkgs.haskell.lib.dontCheck (notBroken superHaskellPkgs.versioning);
    versioning-servant = superNixPkgs.haskell.lib.dontCheck (notBroken superHaskellPkgs.versioning-servant);

  });

}
