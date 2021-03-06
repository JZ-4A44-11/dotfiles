{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #
    ../../modules/system/boot.nix
    ../../modules/system/env.nix
    ../../modules/system/fonts.nix
    ../../modules/system/sound.nix
    ../../modules/system/xorg.nix
  ];

  networking = {
    hostName = "Hoshimachi"; # Suichan 💙
    networkmanager.enable = true;
    dhcpcd.enable = false;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableGlobalCompInit = false;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      gcc
      zsh
      git
      neovim
      wget
      unzip
      gnome.gnome-tweaks
    ];

    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese
      gnome-music
      gnome-terminal
      gedit
      epiphany
      geary
      evince
      totem
      tali
      iagno
      hitori
      atomix
    ]);
  };

  services.openssh.enable = true;

  users.users.mash = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    description = "Akiyama Joseph";
  };

  nix = {
    package = pkgs.nixFlakes;
    trustedUsers = [ "root" "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  documentation.nixos.enable = false;
  system.stateVersion = "22.05";
}

