# Galois
Reproducible setup for Galois

Setup
-----

The setup assumes a directory structure as follows:

```
`- Galois
  `- galois-packages
  | `- projectA
  | | `- subprojectA-A
  | | | `- default.nix
  | | `- subprojectA-B
  | |   `- default.nix
  | `- projectB
  | | `- default.nix
  | `- subprojectA-A.nix
  | `- subprojectA-B.nix
  | `- projectB.nix
  `- configuration.nix
  `- nixpkgs.nix
  `- overlay.nix
```

The directories can be obtained by cloning their respective repository.  The
`default.nix` files are simply obtained by running `cabal2nix . > default.nix`
in their respective repository.  A shell script `setup.sh` will be provided to
set up or update those repositories.

The `default.nix` files are only necessary for those projects you wish to build
locally, either because you are working on them, or because their upstream
version causes problems in your setup.  There should be examples of local builds
available, you can look in `configuration.nix` for projects that have a `local`
variable, and open the corresponding `<project>.nix` to see how the variable is
used.

How it works
------------

The file `overlay.nix` builds a [local Nix
overlay](https://nixos.org/nixpkgs/manual/#chap-overlays) that both:

* adds top-level packages that are **not** packaged in nixpkgs,

* overrides Haskell packages that **are** packaged in nixpkgs, but whose Hackage
  versions are often way behind the development branches.

The file `configuration.nix` allows one to globally pick a version of GHC to be
used by all packages.  The files `nixpkgs.nix` is used to import a version of
nixpkgs with the overlay applied.

Warnings
--------

* It is important that all packages share the same version of their
  dependencies.  For Haskell packages, this is achieved by overriding
  `haskellPackages` (to be precise, using the `extend` utility) so that
  recursive calls to `haskellPackages.callPackage` will also have the overlay
  applied.

* Because we only override `haskellPackages`, it is important that all packages
  use `haskellPackages.callPackage`, rather than
  `haskell.packages.${compiler}.callPackage`.  We try and make this mistake easy
  to avoid by not passing the value of the `compiler` variable explicitly, but
  it is present in the configuration.

* In order to make sure that the sharing is perfect, all packages are
  discouraged from manually passing arguments to `callPackage`.  Instead, if an
  argument is missing (because a package is not yet accounted for in the
  overlay), the expected course of action would be to add said package to
  `overlay.nix`.
