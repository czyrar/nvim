# My Neovim conf

This is my neovim configuration.
Heavily inspired by [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Requirements

- `git`

- `nvim` `v.0.12.0` or above [[INSTALL](https://github.com/neovim/neovim/blob/master/INSTALL.md)]

- `cargo` [[INSTALL](https://doc.rust-lang.org/stable/cargo/getting-started/installation.html)]

- `npm` [[INSTALL](https://github.com/npm/cli)]

- `tree-sitter` [[INSTALL](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md)]

- (optional) `ripgrep` [[INSTALL](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)]

- (optional) `fd` [[INSTALL](https://github.com/sharkdp/fd?tab=readme-ov-file#installation)]

- (optional) `fzf` [[INSTALL](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)]

- (optional) A Nerd Font.

### Arch requisites install (not the font)

```sh
sudo pacman -S git neovim rust npm tree-sitter-cli ripgrep fd fzf
```

## Installing

```sh
# Required
mv ~/.config/nvim{,.bak}

# Recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

# Install
git clone https://github.com/czyrar/nvim.git ~/.config/nvim
```

# What is in here?

The organization is as follows:

```sh
.
├── init.lua
├── nvim-pack-lock.json
├── lua/
│   ├── autocmds.lua
│   ├── keymaps.lua
│   ├── options.lua
│   └── plugins/
│      └── ...
└── after/
    └── lsp
       └── ...
```

`init.lua` is a simple file which installs all packages
and includes the files in the rest of the paths.

`nvim-pack-lock.json` fixes the versions of the packages. Feel free to delete it and update to new versions.

## lua folder

`autocmds.lua` include commands that execute when some action happen and are not related to any plugin.
In particular:

- Highlight when yanking.

- Disable features in big files:
  - Disable Treesitter and LSP if filesize is bigger than 1MB.
  - Disable all syntax highlighting is filesize is bigger than 10MB.

- Help windows open in vertical.

`options.lua` sets my preferred defaults:

- Show numbers (relative) and have them fixed (no LSP/git movement).

- Do not wrap lines.

- By default tabs are 2 spaces.

- Mouse may be used.

- Omit the mode (I prefer statusline).

- Save undo history.

- In general have case-insensitive search.

- Set nice markers for whitecharacters and such.

- Preview substitutions.

- Highlight cursor line.

- Keep 8 lines above and below cursor.

- Confirm before closing without save.

`keymaps.lua` contains my keymaps which are independent of packages.
They are all properly commented.
In general all keymaps may be explored with `:Telescope keymaps`.

### plugins subfolder

One file per plugin with one exception (see below). In the correspondig file at the beginning there is
a description of what each plugin does:

- [`saghen/blink.cmp`](https://github.com/saghen/blink.cmp): provides autocompletion and snippets (through dependencies).

- [`numToStr/Comment.nvim`](https://github.com/numToStr/Comment.nvim): better toggle comments.

- [`stevearc/conform.nvim`](https://github.com/stevearc/conform.nvim): support for formatters. It includes the custom
    configuration for the formatters. Adds two important commands:
  - `:FormatDisable(!)`: disable autoformat (current buffer only if banged).
  - `:FormatEnable`: reenable autoformat.

- [`j-hui/fidget.nvim`](https://github.com/j-hui/fidget.nvim): beautiful notifications.

- [`lewis6991/gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim): git integration and hunk navigation.

- [`folke/lazydev.nvim`](https://github.com/folke/lazydev.nvim): good LSP for Neovim configuration files.

- [`nvim-lualine/lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim): status bar with style similar to [`echasnovski/mini.statusline`](https://github.com/echasnovski/mini.statusline).

- [`neovim/nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig): allow attachment to LSP servers.

- [`kylechui/nvim-surround`](https://github.com/kylechui/nvim-surround): allows for surrounding operations.

- [`akinsho/nvim-toggleterm.lua`](https://github.com/akinsho/nvim-toggleterm.lua): simple terminal split with REPL-like functionality.

- [`stevearc/oil.nvim`](https://github.com/stevearc/oil.nvim): edit filetrees as if they were a simple file.

- [`MeanderingProgrammer/render-markdown.nvim`](https://github.com/MeanderingProgrammer/render-markdown.nvim): render markdown in normal mode.

- [`wellle/targets.vim`](https://github.com/wellle/targets.vim): better textobjects with aliases.

- [`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim): fuzzy finder for many things.

- [`folke/todo-comments.nvim`](https://github.com/folke/todo-comments.nvim): highlight important comments.

- [`romus204/tree-sitter-manager.nvim`](https://github.com/romus204/tree-sitter-manager.nvim): provides UI to install tree-sitters.

- [`folke/which-key.nvim`](https://github.com/folke/which-key.nvim): show help on what keybind are defined.
