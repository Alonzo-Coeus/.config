{ config, pkgs, lib, ... }:
let
  myXMonad = pkgs.callPackage ./xmonad.nix {};
in {
  imports = [./homeLayout.nix ./alacritty.nix ./devEnv/default.nix ./office.nix];
  nixpkgs.config.allowUnfree = true; 

  home.keyboard.layout = "gb";
  home.packages = [
    pkgs.chromium pkgs.spotify pkgs.discord pkgs.vlc
    pkgs.electrum pkgs.cointop
    pkgs.gnome3.nautilus pkgs.gparted pkgs.pavucontrol
    pkgs.lutris pkgs.steam pkgs.vulkan-tools pkgs.minecraft
    myXMonad
  ]; 

  programs = {
    home-manager.enable      = true;
    command-not-found.enable = true;
    git = {
      enable = true;
      userName  = "Alonzo Coeus";
      userEmail = "Alonzo.Coeus@mail.com";
    };
  };
  
  gtk = {
    enable = true;

    theme = {
      package = pkgs.numix-solarized-gtk-theme;
      name  = "numix-solarized-gtk-theme";
    };
  };
}
