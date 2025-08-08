-- Linters to consider per language
-- Check https://github.com/mfussenegger/nvim-lint/blob/master/README.md for available linters
-- Feel free to extend it!
return {
  fortran = { 'fortitude' }, -- Not available in Meson
  lua = { 'selene', 'luacheck' },
  python = { 'mypy', 'sphinx-lint' },
}
