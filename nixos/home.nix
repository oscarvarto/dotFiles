{ pkgs, ... }:

with pkgs;

let
  vscode = (import ./vscode.nix { inherit pkgs; });
  poly-rst = (import ./poly-rst.nix { inherit pkgs; }).poly-rst;
   
  config = {
    allowUnfree = true;
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          intero =
            haskellPackagesNew.callPackage ./intero.nix { };            
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in
{
  home.packages = with pkgs; [
    terminator
    htop
    tree
    zsh-powerlevel9k
    nerdfonts
    pkgconfig
    python2Full
    python3Full
    vscode
    libtensorflow
    haskellPackages.tensorflow
    haskellPackages.haskintex
    libxml2
    libxslt
    zlib
    python36Packages.pip
    python36Packages.numpy
    python36Packages.scipy
    python36Packages.matplotlib
    python36Packages.pandas
    python36Packages.tensorflow
    python36Packages.ipykernel
    python36Packages.lxml
    python36Packages.ipython
    python36Packages.jupyter
    python36Packages.jupyter_core
    pypi2nix
    python36Packages.conda
    (texlive.combine {
      inherit (texlive) scheme-medium collection-langspanish collection-langenglish algorithms cm-super;
    })
    libreoffice-fresh  #Seems to be using openjdk also
    franz
    sbt
    scala
    #openjdk
    openjdk10
    jetbrains.idea-ultimate
    jetbrains.datagrip
    jetbrains.pycharm-professional
    kdeFrameworks.plasma-framework
    kdeApplications.okular
    kdeApplications.kmail
    kdeApplications.ark
    kdeApplications.spectacle
    kdeApplications.gwenview
    plasma-desktop
    plasma-integration
    tmux
    mu
    zotero
  ];

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: (with epkgs.melpaStablePackages; [
      magit          # ; Integrate git <C-x g>
      monokai-theme # ; Nicolas' theme
    ]) ++ (with epkgs.melpaStablePackages; [
      ensime
    ]) ++ (with epkgs.melpaPackages; [    
      zoom           # ; Fixed and automatic balanced window layout
      rainbow-delimiters
      dante
      eglot
      intero
    ]) ++ (with epkgs.elpaPackages; [
      undo-tree      # ; <C-x u> to show the undo tree      
      auctex         # ; LaTeX mode
      beacon         # ; highlight my cursor when scrolling
      nameless       # ; hide current package name everywhere in elisp code
    ]) ++ (with epkgs; [
      notmuch   # From main packages set
      nix-mode
      flycheck
      flycheck-haskell
      flycheck-hdevtools
      flycheck-package
      haskell-mode
      lsp-haskell
      lsp-mode
      lsp-ui
    ]) ++ (with pkgs; [
      # Others
      ag
      aspellDicts.en
      aspellDicts.en-computers
      aspellDicts.en-science
      aspellDicts.es
      emacs-all-the-icons-fonts
      (import ./hie.nix { inherit pkgs; })
      stack
      poly-rst
    ]) ++ (with pkgs.haskellPackages; [      
      # haskellPackages      
      ghcid
      happy
      # haddock TODO: write nix-derivation to compile this
      hlint
      hoogle
      hpack
      structured-haskell-mode
      stylish-haskell
      #intero
    ]) ++ (with pkgs.python36Packages; [
      autopep8
      elpy
      epc
      flake8
      grammalecte
      importmagic
      ipython
      jedi
      virtualenv
      pylint
    ]);
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    sessionVariables = {
      ZSH_CUSTOM="\${HOME}/gitRepos/ZSH_CUSTOM";
      TERM="xterm-256color";
    };
    initExtra = "
POWERLEVEL9K_MODE='nerdfont-complete'
    
# Prompt settings
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%K{white}%k'
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%K{green}%F{black} \\uf155 %f%F{green}%k\\ue0b0%f '

#POWERLEVEL9K_ANACONDA_BACKGROUND=''
POWERLEVEL9K_ANACONDA_FOREGROUND='white'

# VCS colors
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='white'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='magenta'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'

# Dir colors
POWERLEVEL9K_DIR_HOME_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='yellow'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='black'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda vcs dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=''
POWERLEVEL9K_SHORTEN_STRATEGY='truncate_from_right'

source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme

PATH=$PATH:\${HOME}/gitRepos/zsh-scripts
PATH=$PATH:\${HOME}/gitRepos/bash-scripts

export PATH
";
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };

    shellAliases = {
      e = "emacs -nw";
      econf = "emacs -nw \${HOME}/.config/nixpkgs/home.nix";
      code = "code --user-data-dir=\${HOME}/.config/Code/";
      hms = "home-manager switch";
      tmk = "tmux kill-session -t default";
      sp = "HOME=~/spacemacs emacs --daemon=instance1";
      et = "HOME=~/spacemacs emacsclient -qc -nw -s instance1";
      em = "HOME=~/spacemacs emacsclient -nqc -s instance1";
      ppath="echo -e \${PATH//:/\\n}";
      # Blog
      blog="make devserver";
      blog-stop="./develop_server.sh stop";
      blog-update="ghp-import -b master output";
      gpush="git push origin master";
    };
  };

  programs.git = {
    enable = true;
    userEmail = "vargas.torres.oscar@gmail.com";
    userName = "Oscar Vargas Torres";
  };

  programs.home-manager.enable = true;
  programs.home-manager.path = https://github.com/rycee/home-manager/archive/master.tar.gz;
}
