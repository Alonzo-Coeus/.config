{ pkgs, ... }:
let doom-emacs = import ./doom.nix;
in {
  imports = [
    ./commonLisp.nix ./racket.nix
    ./haskell.nix
    ./beam.nix
    ./python.nix ./node.nix
    ./cc.nix ./golang.nix ./rust.nix
    ./latex.nix
  ];


  home.packages = with pkgs; [
    git curl gnumake doom-emacs sqlite
    (aspellWithDicts (ds: with ds; [
      en en-computers en-science
    ]))
  ];

 home.file.".emacs.d/init.el".text = ''
     (load "default.el")
 '';

}
