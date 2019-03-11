# Global helpers
let
  overrideGPlusPlus = nixpkgs: drv:
    nixpkgs.lib.overrideDerivation drv (drv: {
      patchPhase = ''sed -i 's/pgmlg++/pgmlclang++/g' *.cabal'';
    });
in
rec {

  # Global configuration
  compiler = "ghc844";

  # Per-project configuration

  # All project-specific fields should look like:
  # {
  #   local   = true;                       (required) change to `true` if you want to build locally
  #   owner   = "...";                       (optional) owner of the remote (default being "GaloisInc")
  #   path    = "...";                       (optional) directory to source, from repository's root + `project`
  #   project = "...";                       (optional) used as a prefix for `path`
  #   remote  = "...";                       (optional) used to pick the revisions file, can be shared by inheriting
  #   rev     = "...";                       (optional) a revision to pin the package at
  #   wrapper = nixpkgs: drv: ... drv ...;   (optional) function to post-process the derivation
  # }

  abcBridge = {
    local   = true;
    wrapper = nixpkgs: drv:
      overrideGPlusPlus nixpkgs (
      drv
      )
      ;
  };

  aig = {
    local = true;
  };

  binary-symbols = {
    inherit (flexdis86) local remote;
    path = "binary-symbols";
  };

  # NOTE: this is both an actual project and a meta-project
  crucible = {
    local = true;
    path = "crucible";
    remote = "crucible";
  };

  crucible-jvm = {
    inherit (crucible) local remote;
    path = "crucible-jvm";
  };

  crucible-llvm = {
    inherit (crucible) local remote;
    path = "crucible-llvm";
    wrapper = nixpkgs: drv:
      nixpkgs.haskell.lib.addBuildDepends (
        drv
      ) [ nixpkgs.llvm ]
      ;
  };

  crucible-saw = {
    inherit (crucible) local remote;
    path = "crucible-saw";
  };

  crux = {
    inherit (crucible) local remote;
    path = "crux";
  };

  cryptol = {
    local = true;
  };

  cryptol-verifier = {
    local = true; # Darwin fix
    wrapper = nixpkgs: drv:
      overrideGPlusPlus nixpkgs (
      nixpkgs.haskell.lib.addBuildDepends (
        drv
      ) [ nixpkgs.abc nixpkgs.clang ]
      )
      ;
  };

  elf-edit = {
    local = true;
  };

  galois-dwarf = {
    local = true;
    remote = "dwarf";
  };

  flexdis86 = {
    local = true;
    remote = "flexdis86";
  };

  jvm-parser = {
    local = true;
  };

  jvm-verifier = {
    local = true; # Darwin fix
    wrapper = nixpkgs: drv:
      overrideGPlusPlus nixpkgs (
      nixpkgs.haskell.lib.dontCheck
      drv
      )
      ;
  };

  llvm-pretty = {
    local = true;
    owner = "elliottt";
  };

  llvm-pretty-bc-parser = {
    local = true;
    wrapper = nixpkgs: drv:
      nixpkgs.haskell.lib.dontCheck
      drv
      ;
  };

  llvm-verifier = {
    local = true; # Darwin fix
    wrapper = nixpkgs: drv:
      overrideGPlusPlus nixpkgs (
      nixpkgs.haskell.lib.addBuildDepends (
      drv
      ) [ nixpkgs.abc ]
      )
      ;
  };

  # NOTE: This is an umbrella field for multiple projects
  macaw = {
    local = true;
    remote = "macaw";
  };

  macaw-base = {
    inherit (macaw) local remote;
    path = "base";
  };

  macaw-symbolic = {
    inherit (macaw) local remote;
    path = "symbolic";
  };

  macaw-x86 = {
    inherit (macaw) local remote;
    path = "x86";
  };

  macaw-x86-symbolic = {
    inherit (macaw) local remote;
    path = "x86_symbolic";
    wrapper = nixpkgs: drv:
      nixpkgs.haskell.lib.dontCheck
      drv
      ;
  };

  parameterized-utils = {
    local = true;
  };

  saw-core = {
    local = true;
  };

  saw-core-aig = {
    local = true;
  };

  saw-core-coq = {
    local = true;
  };

  saw-core-sbv = {
    local = true;
  };

  saw-core-what4 = {
    local = true;
  };

  saw-script = {
    local = true; # Darwin fix
    rev = "coq-export";
    wrapper = nixpkgs: drv:
      overrideGPlusPlus nixpkgs (
      drv
      );
  };

  sbv = {
    local = true;
    owner = "LeventErkok";
    rev = "v8.0";
  };

  what4 = {
    inherit (crucible) local remote;
    path = "what4";
    wrapper = nixpkgs: drv:
      nixpkgs.haskell.lib.dontCheck drv;
  };

}
