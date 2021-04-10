let #6e3544b73afea08d1428b159b2a57dc9d1724493.tar.gz;
  emacs-overlay = builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/97e6ab3d04cd3bf7e9bdb92b2e965232072076f1.tar.gz;
  pkgs = import <nixpkgs> { overlays = [ (import emacs-overlay) ]; };
  nix-doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz;
  });
in
with pkgs; callPackage nix-doom-emacs {
   doomPrivateDir = ~/.config/doom.d;
   bundledPackages = false;
   emacsPackages = emacsPackagesFor emacsGit;
}
