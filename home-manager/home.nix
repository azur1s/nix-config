# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ config, inputs, outputs, pkgs, ... }: {
  imports = [
    ./alacritty
    ./nvim
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "azur";
    homeDirectory = "/home/azur";
    packages = with pkgs; [
      gcc rustup nodejs python3
      bat exa fzf fd zip unzip ripgrep neofetch
      xdg-utils light
      discord google-chrome
      vscode
    ];
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "azur";
    userEmail = "natapat.samutpong@gmail.com";
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$directory ";
      add_newline = false;
      directory = {
        format = "[$path](fg:blue)[$read_only](fg:red)";
        read_only = " R";
        truncate_to_repo = true;
        truncation_length = 1;
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      ls = "exa";
      cdc = "cd ~/Code";
      up = "sudo nixos-rebuild switch";
    };
    history = {
      size = 100000;
      path = "${config.xdg.dataHome}/.zsh_history";
    };
    initExtra = ''
      zstyle ":completion:*" menu select
      bindkey -e
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^I" complete-word
      bindkey "^[[Z" autosuggest-accept
      bindkey "^H" backward-kill-word
      eval "$(starship init zsh)"
    '';
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
