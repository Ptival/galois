{ stdenv, fetchFromGitHub, coq, fix-to-elim }:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-ornamental-search";

  src = ./local/ornamental-search;

  # src = fetchFromGitHub {
  #   fetchSubmodules = true;
  #   owner = "uwplse";
  #   repo = "ornamental-search";
  #   rev = "2e54ab956d03788066ef739673f7e7b681bce8ac";
  #   sha256 = "0fchk10wxqxp70zv1sxr2869wbcm9vpmpim3kwy271gbm8apgpds";
  # };

  buildInputs = [
    coq
    fix-to-elim
  ];
  propagatedBuildInputs = with coq.ocamlPackages;
    [
      camlp5
      findlib
      ocaml
    ];

  enableParallelBuilding = true;

  preBuild = ''
    cd plugin
    coq_makefile -f _CoqProject -o Makefile
  '';

  installFlags = "COQLIB=$(out)/lib/coq/${coq.coq-version}/";

  passthru = {
    compatibleCoqVersions = v: v == "8.8";
  };
}
