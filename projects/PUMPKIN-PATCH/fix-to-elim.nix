{ stdenv, fetchFromGitHub, coq, coq-plugin-lib }:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-fix-to-elim";

  src = fetchFromGitHub {
    fetchSubmodules = true;
    owner = "uwplse";
    repo = "fix-to-elim";
    rev = "d030756703ef3848f559eda49f9dc037fe8a8acb";
    sha256 = "0p65ynbm1dy5kyzj0p46yg39p0kl137hyfggwn9hz76ivnagjiz4";
  };

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
