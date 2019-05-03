let config = import ./configuration.nix;
    pkgs   = import <nixpkgs> { inherit config; };
in { cirqut-server = pkgs.haskellPackages.cirqut-server; }
