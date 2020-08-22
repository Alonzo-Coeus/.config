let
  emacs-overlay = builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/2cf83a356fc3eef7b1ee22e4843482fedd21e545.tar.gz;
  pkgs = import <nixpkgs> { overlays = [ (import emacs-overlay) ]; };
  nix-doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/vlaci/nix-doom-emacs/archive/edea767bd1a5cf2bbf00760f6070ecf1c2490ebc.tar.gz;
  });
in
with pkgs; callPackage nix-doom-emacs {
   doomPrivateDir = ~/.config/doom.d;
   bundledPackages = false;
   emacsPackages = emacsPackagesFor emacsGit;
}
