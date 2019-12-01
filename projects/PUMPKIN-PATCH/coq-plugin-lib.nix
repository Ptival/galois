{ stdenv, fetchFromGitHub, coq }:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-coq-plugin-lib";

  src = fetchFromGitHub {
    owner = "uwplse";
    repo = "coq-plugin-lib";
    rev = "e4c69376ce3838cf9afff3734f7ddae168c997e1";
    sha256 = "07jy7ch4r613b8hw31sv77a1k6knqmnj8b8d8hli2vjklir8nhig";
  };

  buildInputs = [ coq ];
  propagatedBuildInputs = with coq.ocamlPackages;
    [
      camlp5
      findlib
      ocaml
    ];

  enableParallelBuilding = true;

  preBuild = "coq_makefile -f _CoqProject -o Makefile";

  installFlags = "COQLIB=$(out)/lib/coq/${coq.coq-version}/";

  passthru = {
    compatibleCoqVersions = v: v == "8.8";
  };
}
