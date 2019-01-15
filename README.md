# Galois
Reproducible setup for Galois

Setup
-----

The setup assumes a directory structure as follows:

```
`- Galois
  `- crucible
    `- crucible-llvm
      `- default.nix
    `- what4
      `- default.nix
  `- saw
    `- saw-core
      `- default.nix
    `- saw-core-coq
      `- default.nix
  `- saw-core.nix
  `- saw-core-coq.nix
```

Those directories can be obtained by cloning their respective repository from
Github.  We also assume that each directory contains a `default.nix` file,
which can be obtained by running the `cabal2nix` tool, in a given directory,
invoking it like so:

```
cabal2nix . > default.nix
```

Each sub-project can then be built by going to their parent project root, and
running:

```
nix-build <project>.nix
```

Inter-dependencies are dealt with within each `<project>.nix`.  Compiler
options are defaulted, but can be overridden.  The default should, supposedly,
build correctly.
