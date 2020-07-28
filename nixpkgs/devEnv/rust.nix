{pkgs, ...}:

{
  home.packages = with pkgs; [
    nasm rustup cmake
  ];
}
