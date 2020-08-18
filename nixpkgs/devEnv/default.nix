{ pkgs, ... }:
let doom-emacs = import ./doom.nix;
in {
  imports = [
    ./commonLisp.nix
    ./haskell.nix
    ./python.nix ./node.nix
    ./cc.nix ./golang.nix ./rust.nix
    ./solidity.nix
    ./latex.nix
  ];


  home.packages = with pkgs; [
    git curl gnumake doom-emacs
  ];

 home.file.".emacs.d/init.el".text = ''
     (load "default.el")
 '';

}
