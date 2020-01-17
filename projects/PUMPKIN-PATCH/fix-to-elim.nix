{ stdenv, fetchFromGitHub, coq, coq-plugin-lib }:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-fix-to-elim";

  src = ./local/fix-to-elim;

  # src = fetchFromGitHub {
  #   fetchSubmodules = true;
  #   owner = "uwplse";
  #   repo = "fix-to-elim";
  #   rev = "ae6850ff3133c8d9043b40f27f59f8e779ba5a9b";
  #   sha256 = "0bxcd6hk2adg8iq4bm7bxf2zqh8kvcs1mvjbnlss4nczzkr19lk0";
  # };

  buildInputs = [
    coq
    coq-plugin-lib
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
