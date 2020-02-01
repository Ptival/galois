{ nixpkgs ? import <nixpkgs> {}
}:
with nixpkgs;
callPackage ./sally {}
