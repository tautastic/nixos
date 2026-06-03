{ config, pkgs, nix-jetbrains-plugins, ... }:

let
  pluginList = [
    "neokai"
    "ru.adelf.idea.dotenv"
    "mobi.hsz.idea.gitignore"
    "String Manipulation"
  ];
  clion = pkgs.jetbrains.clion;
  clionWithPlugins = nix-jetbrains-plugins.lib.buildIdeWithPlugins pkgs clion pluginList;
in {
  home.packages = with pkgs; [
    clionWithPlugins
  ];
}
