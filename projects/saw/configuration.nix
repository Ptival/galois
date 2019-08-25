let

  overrideGPlusPlus = nixpkgs: drv:
    nixpkgs.lib.overrideDerivation drv (drv: {
      patchPhase = ''sed -i 's/pgmlg++/pgmlclang++/g' *.cabal'';
    });

in

{

  compiler = "ghc864";

  packages =

    rec {

      # Per-project configuration

      # Project-specific fields:
      #   local = true;                        (required) change to `true` if you want to build locally
      #   base = "...";                        (optional) path to the local copy of the repository
      #   owner = "...";                       (optional) owner of the remote (default being "GaloisInc")
      #   path = "...";                        (optional) directory to source, from repository's root + `project`
      #   project = "...";                     (optional) used as a prefix for `path`
      #   remote = "...";                      (optional) used to pick the revisions file, can be shared by inheriting
      #   rev = "...";                         (optional) a revision to pin the package at
      #   wrapper = nixpkgs: drv: ... drv ...; (optional) function to post-process the derivation

      sawDepsBase = "saw-script/deps";

      abcBridge = {
        base = sawDepsBase;
        local = true;
        wrapper = nixpkgs: drv:
          overrideGPlusPlus nixpkgs (
            drv
          )
        ;
      };

      aig = {
        base = sawDepsBase;
        local = true;
      };

      binary-symbols = {
        inherit (flexdis86) base local remote;
        path = "binary-symbols";
      };

      # NOTE: this is both an actual project and a meta-project
      crucible = {
        base = sawDepsBase;
        local = true;
        path = "crucible";
        remote = {
          repo = "crucible";
        };
      };

      crucible-jvm = {
        inherit (crucible) base local remote;
        path = "crucible-jvm";
      };

      crucible-llvm = {
        inherit (crucible) base local remote;
        path = "crucible-llvm";
        wrapper = nixpkgs: drv:
          nixpkgs.haskell.lib.dontCheck (
            nixpkgs.haskell.lib.addBuildDepends (
              drv
            ) [ nixpkgs.llvm ]
          )
        ;
      };

      crucible-saw = {
        inherit (crucible) base local remote;
        path = "crucible-saw";
      };

      crux = {
        inherit (crucible) base local remote;
        path = "crux";
        wrapper =
          nixpkgs: drv:
          overrideGPlusPlus nixpkgs (
            nixpkgs.haskell.lib.addBuildDepends (
              drv
            ) [ nixpkgs.ncurses ]
          )
        ;
      };

      cryptol = {
        base = sawDepsBase;
        local = true;
      };

      cryptol-verifier = {
        base = sawDepsBase;
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
        base = sawDepsBase;
        local = true;
      };

      galois-dwarf = {
        base = sawDepsBase;
        local = true;
        remote = {
          repo = "dwarf";
        };
      };

      flexdis86 = {
        base = sawDepsBase;
        local = true;
        remote = {
          repo = "flexdis86";
        };
      };

      jvm-parser = {
        base = sawDepsBase;
        local = true;
      };

      jvm-verifier = {
        base = sawDepsBase;
        local = true; # Darwin fix
        wrapper = nixpkgs: drv:
          overrideGPlusPlus nixpkgs (
            nixpkgs.haskell.lib.dontCheck
              drv
          )
        ;
      };

      llvm-pretty = {
        base = sawDepsBase;
        local = true;
        owner = "elliottt";
      };

      llvm-pretty-bc-parser = {
        base = sawDepsBase;
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
        base = sawDepsBase;
        local = true;
        remote = {
          repo = "macaw";
        };
      };

      macaw-base = {
        inherit (macaw) base local remote;
        path = "base";
      };

      macaw-symbolic = {
        inherit (macaw) base local remote;
        path = "symbolic";
      };

      macaw-x86 = {
        inherit (macaw) base local remote;
        path = "x86";
      };

      macaw-x86-symbolic = {
        inherit (macaw) base local remote;
        path = "x86_symbolic";
        wrapper = nixpkgs: drv:
          nixpkgs.haskell.lib.dontCheck
            drv
        ;
      };

      parameterized-utils = {
        base = sawDepsBase;
        local = true;
      };

      saw-core = {
        base = sawDepsBase;
        local = true;
      };

      saw-core-aig = {
        base = sawDepsBase;
        local = true;
      };

      saw-core-coq = {
        base = sawDepsBase;
        local = true;
      };

      saw-core-sbv = {
        base = sawDepsBase;
        local = true;
      };

      saw-core-what4 = {
        base = sawDepsBase;
        local = true;
      };

      saw-script = {
        local = true; # Darwin fix
        remote = {
          rev = "coq-export";
        };
        wrapper = nixpkgs: drv:
          overrideGPlusPlus nixpkgs (
            drv
          );
      };

      sbv = {
        local = true;
        remote = {
          owner = "LeventErkok";
          rev = "v8.0";
        };
      };

      what4 = {
        inherit (crucible) base local remote;
        path = "what4";
        wrapper = nixpkgs: drv:
          nixpkgs.haskell.lib.dontCheck drv;
      };

    };

}
