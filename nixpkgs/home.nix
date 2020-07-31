{ config, pkgs, lib, ... }:
let
  myXMonad = pkgs.callPackage ./xmonad.nix {};
in {
  imports = [./alacritty.nix ./devEnv/default.nix];
  nixpkgs.config.allowUnfree = true; 
  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  home.keyboard.layout = "gb";
  home.packages = [
    pkgs.gnome3.nautilus pkgs.gparted pkgs.pavucontrol
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
  };
}
