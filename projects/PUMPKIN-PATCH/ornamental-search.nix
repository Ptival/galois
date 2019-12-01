{ stdenv, fetchFromGitHub, coq, fix-to-elim }:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-ornamental-search";

  src = fetchFromGitHub {
    fetchSubmodules = true;
    owner = "uwplse";
    repo = "ornamental-search";
    rev = "e11b60c88c0acc9752bee3ce8c7ca626cfca53d6";
    sha256 = "0z9swxk6xgy8lr6f1kwp3rvk380pp4qs50xsyph2bhsrdqpdqi82";
  };

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
