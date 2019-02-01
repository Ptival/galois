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
  #   local   = false;                       (required) change to `true` if you want to build locally
  #   owner   = "...";                       (optional) owner of the remote (default being "GaloisInc")
  #   path    = "...";                       (optional) directory to source, from repository's root + `project`
  #   project = "...";                       (optional) used as a prefix for `path`
  #   remote  = "...";                       (optional) used to pick the revisions file, can be shared by inheriting
  #   wrapper = nixpkgs: drv: ... drv ...;   (optional) function to post-process the derivation
  # }

  abcBridge = {
    local   = false;
    wrapper = nixpkgs: drv:
      overrideGPlusPlus nixpkgs (
      drv
      )
      ;
  };

  aig = {
    local = false;
  };

  binary-symbols = {
    inherit (flexdis86) local remote;
    path = "binary-symbols";
  };

  # NOTE: this is both an actual project and a meta-project
  crucible = {
    local = false;
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
    local = false;
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
    local = false;
  };

  galois-dwarf = {
    local = false;
    remote = "dwarf";
  };

  flexdis86 = {
    local = false;
    remote = "flexdis86";
  };

  jvm-parser = {
    local = false;
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
    local = false;
    owner = "elliottt";
  };

  llvm-pretty-bc-parser = {
    local = false;
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
    local = false;
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
    local = false;
  };

  saw-core = {
    local = false;
  };

  saw-core-aig = {
    local = false;
  };

  saw-core-coq = {
    local = false;
  };

  saw-core-sbv = {
    local = false;
  };

  saw-core-what4 = {
    local = false;
  };

  saw-script = {
    local   = true; # Darwin fix
    wrapper = nixpkgs: drv:
      overrideGPlusPlus nixpkgs (
      drv
      );
  };

  what4 = {
    inherit (crucible) local remote;
    path = "what4";
    wrapper = nixpkgs: drv:
      nixpkgs.haskell.lib.dontCheck drv;
  };

}
