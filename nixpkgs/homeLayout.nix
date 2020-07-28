{config, pkgs, lib, ...}:

{
  home.activation.setupLayout = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    ln -s /media/aux/users/alonzo/Downloads ~
    ln -s /media/aux/users/alonzo/Documents ~
    ln -s /media/aux/users/alonzo/Desktop   ~
    ln -s /media/aux/users/alonzo/workspace ~
  ''; 
}
