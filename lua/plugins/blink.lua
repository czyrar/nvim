-- Autocompletions (C-space)
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if (name == 'blink.cmp' or name == 'blink.lib') and (kind == 'install' or kind == 'update') then
      vim.system({ 'cargo build --release' }, { cwd = ev.data.path })
    end
  end,
})
vim.pack.add {
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp',
}

local cmp = require('blink.cmp')
cmp.setup {
  completion = { menu = { auto_show = false }},
  signature = { enabled = true },
  fuzzy = { sorts = { 'exact', 'score', 'sort_text' }},
}
