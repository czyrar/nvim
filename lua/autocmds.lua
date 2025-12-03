local auto = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight when yanking (copying) text
auto('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup('my-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Establish a mapping of filetypes
local mapping = {
  fypp = 'fortran',
}
vim.filetype.add {
  extension = mapping,
}

-- Disable features when file is too big
local size_limit = 1024 * 1024 -- 1MB
local syntax_limit = 10 * size_limit
auto('FileType', {
  group = augroup('my-bigfile', { clear = true }),
  callback = function(args)
    -- Check if we can use fidget
    local ok, fidget = pcall(require, 'fidget')
    local notify = ok and vim.notify or fidget.notify
    local ft = vim.filetype.match { buf = args.buf } or ''
    local size = vim.fn.getfsize(args.file)
    if size > size_limit then
      vim.bo[args.buf].filetype = 'big-' .. ft
      if size > syntax_limit then
        notify('Very bigfile detected: all features are disabled', vim.log.levels.WARN)
        vim.bo[args.buf].syntax = 'big-' .. ft
      else
        notify('Bigfile detected: LSP and Treesitter disabled', vim.log.levels.WARN)
        vim.bo[args.buf].syntax = ft
      end
    else
      vim.bo[args.buf].filetype = ft
    end
  end,
})

-- Open all new windows as vertical splits
auto('FileType', {
  group = augroup('my-vertical-help', { clear = true }),
  pattern = 'help',
  callback = function()
    vim.cmd 'wincmd L'
  end,
})
