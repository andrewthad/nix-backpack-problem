{ mkDerivation, base, primitive, primitive-containers, stdenv }:
mkDerivation {
  pname = "nix-backpack-problem";
  version = "1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base primitive primitive-containers ];
  license = stdenv.lib.licenses.bsd3;
}
