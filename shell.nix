let config  = import ./configuration.nix;
    nixpkgs = import <nixpkgs> { inherit config; };
    orig    = nixpkgs.pkgs.haskellPackages.callPackage ./default.nix { };
in ( nixpkgs.pkgs.haskell.lib.doBenchmark orig ).env
