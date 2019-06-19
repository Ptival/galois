# Galois
Reproducible setup for Galois

Setup
-----

The setup assumes a directory structure as follows:

```
`- Galois
  `- default.nix
  `- utils.nix
  `- projects
  | `- projectA.nix
  | `- subprojectA-A.nix
  | `- ... (nix expressions for each package)
  | | `- configuration.nix
  | | `- nixpkgs.nix
  | | `- overlay.nix
  | | `- subprojectA-A
  | | | `- default.nix
  | | `- ... (other sub-projects)
  | `- ... (other projects)
```

The top-level `default.nix` lets one build a nix shell with the appropriate
projects built by simply running `nix-shell`.  If a project's package is broken,
and you want to create a shell of everything up to (and including) its
dependencies, you should instead run `nix-shell
./projects/<project>/<package>.nix`.

Each project must define its own `configuration.nix` and `overlay.nix`.  This is
necessary because, at times, different projects might require conflictual
versions of some Haskell packages.  On the other hand, we assume that for a
given project, all packages can agree on all Haskell packages.

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
