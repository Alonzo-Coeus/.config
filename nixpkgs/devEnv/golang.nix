{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    libcap go
  ];
}
