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
    pkgs.lutris pkgs.protontricks pkgs.vulkan-tools pkgs.minecraft 
    (pkgs.steam.override {
	extraLibraries = pkgs: [ pkgs.pipewire.lib ];
    }) 
    myXMonad
    pkgs.bat 
  ]; 
  programs = {
    home-manager.enable      = true;
    command-not-found.enable = true;
    direnv = {
      enable = true;
      enableNixDirenvIntegration = true; 
    }; 
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
  home.file.".bashrc".text = ''
    PATH=~/.npm-global/bin:$PATH
    alias cat='bat'
    source ~/.config/prompt.sh
  '';
}
