
{pkgs, ...}:

{
  home.packages = with pkgs; [
    pipenv python3
  ];
}
