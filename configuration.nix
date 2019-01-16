rec {

  # Global configuration
  compiler = "ghc844";

  # Per-project configuration

  # All project-specific fields should look like:
  # {
  #   local   = false;                       (required) change to `true` if you want to build locally
  #   path    = "...";                       (optional) directory to source, from repository's root
  #   remote  = { ... };                     (required) describes the repository to build from when `local` is `false`
  #   wrapper = nixpkgs: drv: ... drv ...;   (optional) function to post-process the derivation
  # }

  abcBridge = {
    local  = false;
    remote = {
      owner           = "GaloisInc";
      repo            = "abcBridge";
      rev             = "e5b6ddc63349c8b676771be672a40521f63aa8b3";
      sha256          = "0nx4ff5j2vycy4x7bb5aks36jvafhdai1awa77a5bjqmhxzhnd58";
    };
    wrapper = nixpkgs: drv:
      nixpkgs.haskell.lib.dontCheck drv;
  };

  aig = {
    local  = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "aig";
      rev    = "9c6f67ac66cb947577cd4ded494fef10c2a1b2fa";
      sha256 = "1wzzshdpxndfvaip93a3slsnmiiw74h754ap7x28am4lfygf34gx";
    };
  };

  binary-symbols = {
    local  = false;
    path   = "binary-symbols";
    remote = {
      owner  = "GaloisInc";
      repo   = "flexdis86";
      rev    = "2ac3d616996885f93b66c870520381cb09e783ca";
      sha256 = "0vm9ygpw42sdv6khv2xm8jvkrzpg96cg5j456if88xbx3bysn5zx";
    };
  };

  # NOTE: this is both an actual project and a meta-project
  crucible = {
    local  = false;
    path   = "crucible";
    remote = {
      owner  = "GaloisInc";
      repo   = "crucible";
      rev    = "721736289adb34f4d347aace813c83415d1931e3";
      sha256 = "0m5vrlsxzxhhla99jbqps06whg9z2w8qph2cc56ll6cd0iq1w8hy";
    };
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
    remote = {
      owner  = "GaloisInc";
      repo   = "cryptol";
      rev    = "5bad18d3d7b7b925bcde516814bea817e219c134";
      sha256 = "18wpzxs7sdp1mlfzgq76z2bbdskmclpd1g8ick1cc00vlfdsc55h";
    };
  };

  cryptol-verifier = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "cryptol-verifier";
      rev    = "892365d1f152de0d5c5b4f577e5916667f45b895";
      sha256 = "0ny14ynqp9xd9zydf0l3jrj8sn53rqsjcam4pzbdwzjhnj546kpf";
    };
    wrapper = nixpkgs: drv:
      nixpkgs.haskell.lib.disableCabalFlag drv "build-css";
  };

  elf-edit = {
    local  = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "elf-edit";
      rev    = "a9428d847f63cddfbd38eb3b0fea07153dbcd18f";
      sha256 = "0h0w6apsygx9w95rx86rlgaq5jjavkz5skvfqbb80jwz01ph9i81";
    };
  };

  galois-dwarf = {
    local  = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "dwarf";
      rev    = "9f9e04eddca691f5d0b838ec2d850b343fbbd115";
      sha256 = "0z8fjnxc9qjzpgsyrbbhp7dh3cai7zvni2iz46y0ra747vp476k8";
    };
  };

  flexdis86 = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "flexdis86";
      rev    = "2ac3d616996885f93b66c870520381cb09e783ca";
      sha256 = "0vm9ygpw42sdv6khv2xm8jvkrzpg96cg5j456if88xbx3bysn5zx";
    };
  };

  jvm-parser = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "jvm-parser";
      rev    = "f37d40201271e3fa3ece8aa8346f87e4b211c82f";
      sha256 = "19qg3zf4gn0lc2gl2gggjd6d033bddvpy80kkzv8msbijrhppg6i";
    };
  };

  jvm-verifier = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "jvm-verifier";
      rev    = "f7755eb6016c76345c0fb63dca07c5bffd149ae0";
      sha256 = "0qq28np2v5f43k92zcfkfwsflzbx0kasfq57zdfk1cvchd0ix7ja";
    };
    wrapper = nixpkgs: drv:
      nixpkgs.haskell.lib.disableCabalFlag (
      nixpkgs.haskell.lib.dontCheck
      drv
      ) "build-jss"
      ;
  };

  llvm-pretty = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "llvm-pretty";
      rev    = "4690fa103c6ce4d13fb659f0ac76b6c059157280";
      sha256 = "128ks93jpcxsas6g1qi091zxc25ijszd97is800ynfmf5fzgb958";
    };
  };

  llvm-pretty-bc-parser = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "llvm-pretty-bc-parser";
      rev    = "181713af59587ae61b4f4625407cc5e795b8c70b";
      sha256 = "1whd8fgihn9rrfcl1fpg5rxy6a8lm897hddisgwymldzg5x3a36x";
    };
    wrapper = nixpkgs: drv:
      nixpkgs.haskell.lib.dontCheck drv;
  };

  llvm-verifier = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "llvm-verifier";
      rev    = "16600b3ddbe7cc32ed2eebae63f64b18cb78e5b0";
      sha256 = "0f24yfsb06c592y8ym33qlsic8rbyn8wyh92j9iw474l3hqs9pir";
    };
    wrapper = nixpkgs: drv:
      nixpkgs.haskell.lib.disableCabalFlag (
      nixpkgs.haskell.lib.disableCabalFlag (
      nixpkgs.haskell.lib.disableLibraryProfiling (
      nixpkgs.haskell.lib.dontCheck
      drv
      )
      ) "build-lss"
      ) "build-utils"
      ;
  };

  # NOTE: This is an umbrella field for multiple projects
  macaw = {
    local  = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "macaw";
      rev    = "190ed0712115559774c7c0d86833c6becd949fe2";
      sha256 = "187l803swk6313dgcvn8n2sd6sjmi5zm9vpc6yzf46byaf8ziax9";
    };
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
      nixpkgs.haskell.lib.dontCheck drv;
};

  parameterized-utils = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "parameterized-utils";
      rev    = "3e5fdd357d5fdd466dc0370ae730590d832529aa";
      sha256 = "0zkjvi99wg0qi2113a2rrr7lf9b7c31rsqmb5h9y0g2a42339ylc";
    };
  };

  saw-core = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "saw-core";
      rev    = "206857b8c3dc3f303626263a583e5bbef20ca9ee";
      sha256 = "1606dkzcm0d713lvsvwrbl76qgkps3ipm87fz0l3jqyhb5ndi0sq";
    };
  };

  saw-core-aig = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "saw-core-aig";
      rev    = "a9d971d1f4f3a0dcbbdf15a77d00fcc4d82183ea";
      sha256 = "0yw0xidgqs4j306rl4hmrjs2f4rgidbijh2s4zj4xmlxxanb1z43";
    };
  };

  saw-core-coq = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "saw-core-coq";
      rev    = "9e60c1d6e44958124dc7eeb209e6a0a99f71e2c7";
      sha256 = "0qdjn3m6mjhkk4g6s3hldqjjsfzxwwbphn5fwb7sb4yzxr8xhl5h";
    };
  };

  saw-core-sbv = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "saw-core-sbv";
      rev    = "5b2fe36934b0688251774971552371d186d5e56e";
      sha256 = "05xaf5a80p9pwl4nhz1s9xqcgb8d5sp9y14sr4rpr2hyd69m63qx";
    };
  };

  saw-core-what4 = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "saw-core-what4";
      rev    = "8a52bf9cb8ce42f5a34e9aab4880a2d92e932132";
      sha256 = "0qasmpw8fqppcbfwg8ar8n00hsp61wnsln28cgh0f8zva0gy6b82";
    };
  };

  saw-script = {
    local = false;
    remote = {
      owner  = "GaloisInc";
      repo   = "saw-script";
      rev    = "52e160a2a57ce71e8643a25c170a69666efcd2a1";
      sha256 = "0sar9946832pdg8fkg30fpdizxfnwwix62m2043h9nj4lh90lppn";
    };
  };

  what4 = {
    inherit (crucible) local remote;
    path = "what4";
    wrapper = nixpkgs: drv:
      nixpkgs.haskell.lib.dontCheck drv;
  };

}
