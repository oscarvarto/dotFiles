{ config, pkgs, ... }:

let
 doom-emacs = pkgs.callPackage (builtins.fetchTarball {
   url = https://github.com/vlaci/nix-doom-emacs/archive/develop.tar.gz;
 }) {
   doomPrivateDir = /home/oscarvarto/.doom.d;  # Directory containing your config.el init.el
                                               # and packages.el files
 };
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "oscarvarto";
  home.homeDirectory = "/home/oscarvarto";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [ 
    # coursier
    doom-emacs
    element-desktop
    jdk
    jetbrains.idea-community
    nerdfonts
    sbt
    scala
    spotify
  ];

  home.file.".emacs.d/init.el".text = ''
      (load "default.el")
  '';

  services.emacs = {
    enable = true;
    package = doom-emacs;
  };

  programs.emacs.package = doom-emacs;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true; # Don't forget to add `environment.pathsToLink = [ "/share/zsh" ];` to your system configuration
    # enableSyntaxHighlighting = true; # complains that this option does not exist
    # defaultKeymap = "emacs";

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };

    shellAliases = {
      # Emacs related
      et   = "emacsclient -qc -nw";
      suet = "SUDO_EDITOR=\"emacsclient -qc -nw\" sudo -e";
      em   = "emacsclient -nqc";
      suem = "SUDO_EDITOR=\"emacsclient -nqc\" sudo -e";
      er = "systemctl --user restart emacs.service";

      # conveniences
      hms = "home-manager switch";
      nrs = "sudo nixos-rebuild switch";
      eth = "et ~/.config/nixpkgs/home.nix";
      emh = "em ~/.config/nixpkgs/home.nix";
      etcfg = "suet /etc/nixos/configuration.nix";
    };
  };

}
