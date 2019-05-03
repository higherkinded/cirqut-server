{
  packageOverrides = pkgs: {
    haskellPackages = pkgs.haskellPackages.override {
      overrides = haskellPackagesNew: haskellPackagesOld: {
        cirqut-server =
          haskellPackagesNew.callPackage ./default.nix { };
        beam-core =
          haskellPackagesNew.callPackage ./nix-overrides/beam-core.nix { };
        beam-postgres =
          haskellPackagesNew.callPackage ./nix-overrides/beam-postgres.nix { };
        beam-migrate =
          haskellPackagesNew.callPackage ./nix-overrides/beam-migrate.nix { };
      };
    };
  };
}
