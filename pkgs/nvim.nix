{ neovimUtils
, vimUtils
, vimPlugins
, wrapNeovimUnstable
, lib

, neovim-unwrapped
, ripgrep
, nil
, statix
, stylua
, gotools
, ruff
, alejandra
}:
let
    nvim-config = neovimUtils.makeNeovimConfig {
      plugins = [
        (vimUtils.buildVimPlugin {
          name = "fruit-nvim-config";
          dependencies = builtins.attrValues {
            inherit (vimPlugins)
              cmp-async-path
              cmp-buffer
              cmp-cmdline
              cmp-nvim-lsp
              cmp_luasnip
              conform-nvim
              git-conflict-nvim
              kanagawa-nvim
              lualine-nvim
              luasnip
              mini-nvim
              nvim-cmp
              nvim-lspconfig
              nvim-web-devicons
              telescope-nvim
              ;
            ts = vimPlugins.nvim-treesitter.withAllGrammars;
          };
          src = ../nvim;
        })
      ];
      wrapRc = false;
    };


in
(wrapNeovimUnstable neovim-unwrapped nvim-config).overrideAttrs(old: {
    generatedWrapperArgs = old.generatedWrapperArgs or [] ++ [
        "--suffix"
        "PATH"
        ":"
        (lib.makeBinPath [
            ripgrep
            nil
            stylua
            gotools
            ruff
            alejandra
        ])
    ];
})
