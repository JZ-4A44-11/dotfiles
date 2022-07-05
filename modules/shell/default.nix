{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [ neofetch ];

  home.file = {
    ".config/neofetch".source = config.lib.file.mkOutOfStoreSymlink ../../config/neofetch;
  };
}
