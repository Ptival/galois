self: super:
{
  coq = super.coq_8_8;
  coqPackages = super.coqPackages_8_8 // rec {
    coq-plugin-lib = self.callPackage ./coq-plugin-lib.nix {};
    fix-to-elim = self.callPackage ./fix-to-elim.nix {
      inherit coq-plugin-lib;
    };
    ornamental-search = self.callPackage ./ornamental-search.nix {
      inherit fix-to-elim;
    };
    PUMPKIN-PATCH = self.callPackage ./PUMPKIN-PATCH.nix {
      inherit coq-plugin-lib;
      inherit fix-to-elim;
      inherit ornamental-search;
    };
  };
}
