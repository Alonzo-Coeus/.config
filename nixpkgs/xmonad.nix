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
        rev = "65867cc6af66f756c72a79a7f1f30ca64b541355";
        sha256 = "a6bbc1731f430c214e700ac459d4f10484e799cffe46f16757e3234e3adf741f";
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



