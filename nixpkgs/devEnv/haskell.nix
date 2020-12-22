let
  ihp-new = import (builtins.fetchTarball { url="https://ihp.digitallyinduced.com/ihp-new.tar.gz"; });
in
{pkgs, ...}:
{
  

  home.packages = with pkgs; [
    ghc                      # Compiler
    cabal-install stack      # Package Managers
    haskellPackages.ghcide                  # Language Server
    haskellPackages.haskell-language-server #
    cabal2nix                # Util
    ihp-new
  ];
}
