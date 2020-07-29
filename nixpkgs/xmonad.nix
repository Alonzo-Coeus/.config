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
        rev = "baaa64f103fc822eb11e7da3289747ef6044f835";
        sha256 = "7ff57d0185768b675fc2a4cdd424d9bef5c96f5433fcc0ade0364db8d1a502c8";
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



