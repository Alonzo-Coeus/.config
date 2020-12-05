{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs nodePackages.javascript-typescript-langserver 
  ];
}
