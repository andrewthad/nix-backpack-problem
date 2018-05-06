{ mkDerivation, base, containers, deepseq, fetchgit, gauge
, ghc-prim, primitive, QuickCheck, quickcheck-classes, random
, stdenv, tasty, tasty-quickcheck
}:
mkDerivation {
  pname = "primitive-containers";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/andrewthad/primitive-containers";
    sha256 = "1zxfhv68wk9bspkihr9ma4y1c6qqxisnisdvwbvdzjx9gcqha2x2";
    rev = "c7478228696d2d6423f8b88fb2a47017427313cb";
  };
  libraryHaskellDepends = [ base primitive ];
  testHaskellDepends = [
    base containers primitive QuickCheck quickcheck-classes tasty
    tasty-quickcheck
  ];
  benchmarkHaskellDepends = [
    base containers deepseq gauge ghc-prim primitive random
  ];
  doHaddock = false;
  doCheck = false;
  homepage = "https://github.com/andrewthad/primitive-containers#readme";
  license = stdenv.lib.licenses.bsd3;
}
