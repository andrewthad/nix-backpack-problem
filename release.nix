let
  config = {
    packageOverrides = pkgs: rec {
      haskell = pkgs.haskell // {
        packages = pkgs.haskell.packages // {
          ghc841 = pkgs.haskell.packages.ghc841.override {
            overrides = haskellPackagesNew: haskellPackagesOld: rec {
              nix-backpack-problem =
                haskellPackagesNew.callPackage ./default.nix { };

              primitive =
                haskellPackagesNew.callPackage ./primitive.nix { };

              primitive-containers =
                haskellPackagesNew.callPackage ./primitive-containers.nix { };

              quickcheck-classes =
                haskellPackagesNew.callPackage ./quickcheck-classes.nix { };
            };
          };
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in
  pkgs.haskell.packages.ghc841.nix-backpack-problem
