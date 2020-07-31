{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git curl gnumake
  ];
  imports = [
    ./doom.nix
    ./haskell.nix
    ./python.nix ./node.nix
    ./cc.nix ./golang.nix ./rust.nix
    ./latex.nix
  ];
}
