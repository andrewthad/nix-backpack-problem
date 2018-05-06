{ mkDerivation, base, fetchgit, ghc-prim, stdenv, transformers }:
mkDerivation {
  pname = "primitive";
  version = "0.6.3.0";
  src = fetchgit {
    url = "https://github.com/andrewthad/primitive";
    sha256 = "1xjff65nvhlh46mlfmqvbv2ndzq9sql6pwpmmf11s5ikpn3cz83c";
    rev = "eff8ce559ece91f51c7fbe609e296f43bb3f3723";
  };
  libraryHaskellDepends = [ base ghc-prim transformers ];
  homepage = "https://github.com/haskell/primitive";
  description = "Primitive memory-related operations";
  license = stdenv.lib.licenses.bsd3;
}
