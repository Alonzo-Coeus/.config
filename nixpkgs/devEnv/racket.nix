{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.racket
  ];
}
