{ compiler ?  "ghc844" }:
let
  config = {
    packageOverrides = pkgs: rec {
      haskell = pkgs.haskell // {
        packages = pkgs.haskell.packages // {
          ${compiler} = pkgs.haskell.packages.${compiler}.override {
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
  pkgs.haskell.packages.${compiler}.nix-backpack-problem
