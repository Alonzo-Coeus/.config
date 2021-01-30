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
        rev = "44717a2cb8ad2494715c299750ae501cae3df1a7";
        sha256 = "1d3e07ae4f75967d2c5f4804a9dfaf7ba77ea9496ba27058e3f9fa2b74023b75";
      };
      isLibrary = false;
      isExecutable = true;
      doHaddock = false;
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



