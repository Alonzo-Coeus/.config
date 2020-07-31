{ nixpkgs ? import <nixpkgs> { } }:
let drv = { mkDerivation, base, containers, deepseq, hpack, lens, mtl
    , pretty-simple, process, stdenv, string-conversions, time, X11, xmonad
    , xmonad-contrib }:
    mkDerivation rec {
      pname = "my-xmonad";
      version = "0.1.0";
      src = nixpkgs.pkgs.fetchgit {
        url = "https://github.com/Alonzo-Coeus/.xmonad";
        name = "my-xmonad";
        rev = "e3fa438d93c8de4fb4f2c0ac9d60fa3eb0e509b6";
        sha256 = "edd7b7691a8c5ae87b5ed668059c5dec0cd961ec39e2d35d79fa3ca8f5ffda15";
      };
      isLibrary = false;
      isExecutable = true;
      doHaddock = false;
      libraryToolDepends = [ hpack ];
      executableHaskellDepends = [
        base
        containers
        deepseq
        lens
        mtl
        pretty-simple
        process
        X11
        xmonad
        xmonad-contrib
      ];
      license = stdenv.lib.licenses.gpl2;
    };
in nixpkgs.pkgs.haskell.packages."ghc865".callPackage drv { }



