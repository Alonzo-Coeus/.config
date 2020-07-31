{pkgs, ...}:

{
  home.packages = with pkgs; [
    ghc                      # Compiler
    cabal-install stack      # Package Managers
    cabal2nix                # Util
  ];
}
