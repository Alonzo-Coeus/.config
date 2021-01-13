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
        rev = "9f1fcf9ed5e7bd07256bc18c32b150d02db0aa80";
        sha256 = "4e92ae10a85aef3ba4268c7f8c88a872569962ac0e99662f0df8f196cfcad725";
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



