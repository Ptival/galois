let configuration = import ./configuration.nix; in
{ compiler ? configuration.compiler
}:
selfNixPkgs: superNixPkgs:
let

  makePackage =
    packageName:
      let
        config      = configuration.${packageName};
        packagePath = config.path or "";
        projectPath = (config.project or packageName) + packagePath;
        remoteName  = config.remote or packageName;
        remoteInfo  = builtins.fromJSON (builtins.readFile (./galois-packages/revisions + "/${packageName}.json"));
        drv         =
          if config.local
          then
            selfNixPkgs.haskellPackages.callPackage
              (./galois-packages + "/${remoteName}/${packagePath}/default.nix")
              {}
          else
            selfNixPkgs.haskellPackages.callCabal2nix
              packageName
              ((selfNixPkgs.fetchFromGitHub remoteInfo) + "/${packagePath}")
              {}
          ;
        noWrapper   = nixpkgs: drv: drv;
      in
      # If the `config` contains a `wrapper` field, said field is a function
      # expecting `nixpkgs` and the derivation as input, and that performs
      # modifications to the derivation.  We simply apply the function to the
      # current derivation `drv`, or in its absence, apply a function
      # `noWrapper` that returns the derivation unchanged instead.
      (config.wrapper or noWrapper) selfNixPkgs drv
      ;

  nixpkgs = selfNixPkgs; # just so that we can write "inherit nixpkgs;"

  notBroken = drv: superNixPkgs.haskell.lib.overrideCabal drv (drv: { broken = false; });

in
{
  abc                = superNixPkgs.callPackage ./galois-packages/abc.nix { inherit nixpkgs; };
  binary-symbols     = makePackage "binary-symbols";
  codescape          = makePackage "codescape";
  crucible           = makePackage "crucible";
  crucible-jvm       = makePackage "crucible-jvm";
  crucible-llvm      = makePackage "crucible-llvm";
  crucible-saw       = makePackage "crucible-saw";
  crux               = makePackage "crux";
  cryptol-verifier   = makePackage "cryptol-verifier";
  elf-edit           = makePackage "elf-edit";
  flexdis86          = makePackage "flexdis86";
  galois-dwarf       = makePackage "galois-dwarf";
  jvm-verifier       = makePackage "jvm-verifier";
  llvm-verifier      = makePackage "llvm-verifier";
  macaw-base         = makePackage "macaw-base";
  macaw-symbolic     = makePackage "macaw-symbolic";
  macaw-x86          = makePackage "macaw-x86";
  macaw-x86-symbolic = makePackage "macaw-x86-symbolic";
  saw-core           = makePackage "saw-core";
  saw-core-aig       = makePackage "saw-core-aig";
  saw-core-coq       = makePackage "saw-core-coq";
  saw-core-sbv       = makePackage "saw-core-sbv";
  saw-core-what4     = makePackage "saw-core-what4";
  saw-script         = makePackage "saw-script";
  what4              = makePackage "what4";

  haskellPackages = nixpkgs.haskell.packages.${compiler}.extend (selfHaskellPkgs: superHaskellPkgs: {
    abcBridge             = makePackage "abcBridge";
    # Current aeson does not build with ghc844 because it's missing `contravariant` dependency
    # cf. https://github.com/NixOS/nixpkgs/issues/53620
    aeson                 = superNixPkgs.haskell.lib.addBuildDepends superHaskellPkgs.aeson [ selfHaskellPkgs.contravariant ];
    aig                   = makePackage "aig";
    cryptol               = makePackage "cryptol";
    jvm-parser            = makePackage "jvm-parser";
    llvm-pretty           = makePackage "llvm-pretty";
    llvm-pretty-bc-parser = makePackage "llvm-pretty-bc-parser";
    parameterized-utils   = makePackage "parameterized-utils";
    sbv                   = makePackage "sbv";
    # Tests require hspec, skip them
    versioning            = superNixPkgs.haskell.lib.dontCheck (notBroken superHaskellPkgs.versioning);
    versioning-servant    = superNixPkgs.haskell.lib.dontCheck (notBroken superHaskellPkgs.versioning-servant);
  });
}
