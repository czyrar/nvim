return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  -- Configure LazyVim to load the theme I want
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
