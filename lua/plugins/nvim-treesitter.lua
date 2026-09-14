-- Tree sitter support
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
}

local ts_filetypes = {
  sh = 'bash',
  fortran = 'fortran',
  lua = 'lua',
  python = 'python'
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.tbl_keys(ts_filetypes),
  callback = function(args)
    local ft = vim.filetype.match { buf = args.buf } or ''
    local ts = require('nvim-treesitter')
    if (not vim.tbl_contains(ts.get_installed(), ft)) then
      if (not vim.tbl_contains(ts.get_available(), ft)) then
        return
      end
      ts.install(ts_filetypes[ft])
    end
    vim.treesitter.start()

    -- Folds
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.cmd('normal zR')

    -- Indent
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
})
