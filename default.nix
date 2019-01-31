{ nixpkgs ? import ./nixpkgs.nix }:
with nixpkgs;
mkShell {
  buildInputs = [
    crucible
    crucible-jvm
    crucible-llvm
    crucible-saw
    cryptol-verifier
    elf-edit
    flexdis86
    jvm-verifier
    llvm-verifier
    macaw-base
    macaw-symbolic
    macaw-x86
    macaw-x86-symbolic
    saw-core
    saw-core-aig
    saw-core-coq
    saw-core-sbv
    saw-core-what4
    # NOTE: temporarily commented out as there is an upstream bug
    saw-script
    what4
    haskellPackages.abcBridge
    haskellPackages.aig
    haskellPackages.cryptol
    haskellPackages.llvm-pretty
    haskellPackages.parameterized-utils
  ];
}
