{ stdenv, fetchFromGitHub, coq, coq-plugin-lib, fix-to-elim, ornamental-search
}:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-PUMPKIN-PATCH";

  src = fetchFromGitHub {
    fetchSubmodules = true;
    owner = "uwplse";
    repo = "PUMPKIN-PATCH";
    rev = "e1ddd4040460f5d2f9599e609f157130a5739a14";
    sha256 = "052l6bjqa67202jl52gfzv1n8i4icwhn2d192sparf3d65j91xzi";
  };

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
