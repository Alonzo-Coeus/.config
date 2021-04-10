{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    erlang
    elixir
  ];
}
