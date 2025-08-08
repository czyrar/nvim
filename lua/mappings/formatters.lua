-- Feel free to add more
-- https://github.com/mimikun/mason-conform.nvim/blob/master/lua/mason-conform/mappings/filetype.lua
return {
  bash = { 'shfmt' },
  fortran = { 'fprettify' },
  lua = { 'stylua' },
  markdown = { 'markdownlint' },
  python = { 'autopep8', 'ruff' },
  rust = { 'rustfmt' },
  sh = { 'shfmt' },
  tex = { 'bibtex-tidy', 'latexindent' },
  zsh = { 'shfmt' },
}
