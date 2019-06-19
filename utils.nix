{ projectConfiguration
}:
rec {

  getPackagePathToRepo = pkg: pkg.base or ".";

  getPackagePathInRepo = pkg: pkg.path or ".";

  # getPackageRemoteName = pkgName: projectConfiguration.${pkgName}.remote or pkgName;

  # getPackageLocalPath  =
  #   projectName: pkgName:
  #   let
  #     pkg = projectConfiguration.${pkgName};
  #   in
  #     "${getPackagePathToRepo pkg}/${getPackageRemoteName projectName pkgName}/${getPackagePathInRepo pkg}";

  makePackage =
    nixpkgs: projectName: packageName:
    let
      pkg           = projectConfiguration.packages.${packageName};
      pkgPathToRepo = getPackagePathToRepo pkg;
      pkgPathInRepo = getPackagePathInRepo pkg;
      remoteName    = pkg.remote or packageName;
      remoteInfo    = builtins.fromJSON (builtins.readFile (./projects/revisions + "/${packageName}.json"));
      drv           =
        if pkg.local
        then
          nixpkgs.haskellPackages.callPackage
            (./projects + "/${projectName}/${pkgPathToRepo}/${remoteName}/${pkgPathInRepo}/default.nix")
            {}
        else
          nixpkgs.haskellPackages.callCabal2nix
            packageName
            ((nixpkgs.fetchFromGitHub remoteInfo) + "/${pkgPathInRepo}")
            {}
      ;
      noWrapper   = nixpkgs: drv: drv;
    in
      # If the `pkg` contains a `wrapper` field, said field is a function
      # expecting `nixpkgs` and the derivation as input, and that performs
      # modifications to the derivation.  We simply apply the function to the
      # current derivation `drv`, or in its absence, apply a function
      # `noWrapper` that returns the derivation unchanged instead.
      (pkg.wrapper or noWrapper) nixpkgs drv
  ;

}
