let #97e6ab3d04cd3bf7e9bdb92b2e965232072076f1.tar.gz; ae860b65a621334ec7a4df9decab21c38a1aceb6 
  emacs-overlay = builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/494ca21216531e987939106313daf97917d61cd7.tar.gz;
  pkgs = import <nixpkgs> { overlays = [ (import emacs-overlay) ]; };
  nix-doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/vlaci/nix-doom-emacs/archive/f2849e51a557b78214ab19bb504fb936d8d513d4.tar.gz;
  });
in
with pkgs; callPackage nix-doom-emacs {
   doomPrivateDir = ~/.config/doom.d;
   bundledPackages = true;
   #emacsPackages = emacsPackagesFor (emacsGit.override {nativeComp = true;});
   #extraPackages = epkgs : [epkgs.use-package epkgs.general epkgs.evil-goggles epkgs.avy epkgs.ivy epkgs.ivy-rich];
}
