{ mkDerivation, abcBridge, aig, array, base, base-compat
, containers, cryptol, data-inttrie, executable-path, filepath
, integer-gmp, saw-core, saw-core-aig, saw-core-sbv, saw-core-what4
, sbv, stdenv, text, vector, what4
}:
mkDerivation {
  pname = "cryptol-verifier";
  version = "0.1";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aig array base base-compat containers cryptol data-inttrie
    executable-path filepath integer-gmp saw-core saw-core-aig
    saw-core-sbv saw-core-what4 sbv text vector what4
  ];
  executableHaskellDepends = [
    abcBridge array base containers cryptol saw-core saw-core-aig text
  ];
  description = "Representing Cryptol in SAWCore";
  license = stdenv.lib.licenses.bsd3;
}
