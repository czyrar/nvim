# My Neovim conf

This is my neovim configuration.
Heavily inspired by [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Requirements

- `git`

- `nvim` `v.0.11` or above [[INSTALL](https://github.com/neovim/neovim/blob/master/INSTALL.md)]

- `cargo` [[INSTALL](https://doc.rust-lang.org/stable/cargo/getting-started/installation.html)]

- `npm` [[INSTALL](https://github.com/npm/cli)]

- `tree-sitter` [[INSTALL](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md)]

- (optional) `ripgrep` [[INSTALL](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)]

- (optional) `fd` [[INSTALL](https://github.com/sharkdp/fd?tab=readme-ov-file#installation)]

- (optional) A Nerd Font. If not installed then set `vim.g.have_nerd_font = false` in `init.lua`.

### Arch requisites install (not the font)

```sh
sudo pacman -S git neovim rust npm tree-sitter-cli ripgrep fd
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
├── lazy-lock.json
└── lua
    ├── autocmds.lua
    ├── keymaps.lua
    ├── options.lua
    ├── plugins
    │   └── ...
    └── themes
        └── ...
```

`init.lua` is a simple file which just bootstraps [lazy.nvim](https://github.com/folke/lazy.nvim) (the package manager)
and includes the files in the rest of the paths.

`lazy.lock` fixes the versions of the packages. Feel free to delete it and update to new versions.

## lua folder

`autocmds.lua` include commands that execute when some action happen and are not related to any plugin.
In particular:

- Highlight when yanking.

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

### plugins folder

One file per plugin with one exception (see below). In the correspondig file at the beginning there is
a description of what each plugin does:

- [`saghen/blink.cmp`](https://github.com/saghen/blink.cmp): provides autocompletion and snippets (through dependencies).

- [`numToStr/Comment.nvim`](https://github.com/numToStr/Comment.nvim): better toggle commands.

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

- [`nvim-treesitter/nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter): treesitter queries and highlight. Includes submodules:
    - [`nvim-treesitter/nvim-treesitter-context`](https://github.com/nvim-treesitter/nvim-treesitter-context): provides context in the upper part of the screen.
    - [`nvim-treesitter/nvim-treesitter-textobjects`](https://github.com/nvim-treesitter/nvim-treesitter-textobjects): provides textobjects for the language in buffer.

- [`Wansmer/treesj`](https://github.com/Wansmer/treesj): wrap/unwrap nested code.

- [`folke/which-key.nvim`](https://github.com/folke/which-key.nvim): show help on what keybind are defined.

### themes folder

Where purely theme plugins are located. They are loaded first of all.
To change theme edit the last line at `init.lua`.
