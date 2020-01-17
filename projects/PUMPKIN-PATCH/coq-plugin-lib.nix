{ stdenv, fetchFromGitHub, coq }:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-coq-plugin-lib";

  src = ./local/coq-plugin-lib;

  # src = fetchFromGitHub {
  #   owner = "uwplse";
  #   repo = "coq-plugin-lib";
  #   rev = "c095e51d883d31863f8ef367bf39b2933224f663";
  #   sha256 = "0811mciygiw3lgn298y9xqcsxddq9d0ajshwac780n5ifzzw8by4";
  # };

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
