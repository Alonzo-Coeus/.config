{pkgs, ...}:
{
  home.packages = with pkgs; [
                     sbcl 
                     lispPackages.quicklisp lispPackages.asdf-system-connections
                  ];
}
