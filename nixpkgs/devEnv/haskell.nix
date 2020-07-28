{pkgs, ...}:

{
  home.packages = with pkgs; [
    ghc                      # Compiler
    cabal-install stack      # Package Managers
    haskellPackages.ghcide   # Language Server
    cabal2nix                # Util
  ];
}
