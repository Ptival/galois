{ stdenv, fetchFromGitHub, coq, coq-plugin-lib, fix-to-elim, ornamental-search
}:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-PUMPKIN-PATCH";

  src = ./local/PUMPKIN-PATCH;

  # src = fetchFromGitHub {
  #   fetchSubmodules = true;
  #   owner = "uwplse";
  #   repo = "PUMPKIN-PATCH";
  #   rev = "ab369aa1466c416369e339cf5030831c556f4e07";
  #   sha256 = "0wpmf2skw6az0bmwxrlxy73g61ryd1nr73py8ybsvs6sr1cn2ynk";
  # };

  buildInputs = [
    coq
    coq-plugin-lib
    fix-to-elim
    ornamental-search
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
