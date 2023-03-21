{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      neogit
    ];

    extraPackages = with pkgs; [
      gcc
      nixpkgs-fmt rnix-lsp
      sumneko-lua-language-server
      tree-sitter
      yaml-language-server
      nodePackages_latest.typescript
      nodePackages_latest.typescript-language-server
    ];

    extraConfig = let
      luaRequire = module:
        builtins.readFile (builtins.toString ./config + "/${module}.lua");
      luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
        "init"
        "pack"
      ]);
    in ''
      lua << EOF
      ${luaConfig}
      EOF
    '';
  };
}
