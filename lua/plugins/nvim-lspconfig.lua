-- LSP protocol
--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.pack.add {
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',
}
require('mason').setup()
require('mason-lspconfig').setup()

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
  callback = function()
    local builtin = require 'telescope.builtin'
    require('which-key').add {
      { 'gr', group = 'LSP', desc = 'LSP: [G]oto', mode = 'n' },
      { 'grn', vim.lsp.buf.rename, desc = 'LSP: [R]e[n]ame', mode = 'n' },
      { 'gra', vim.lsp.buf.code_action, desc = 'LSP: [G]oto Code [A]ction', mode = { 'n', 'x' } },
      { 'grD', vim.lsp.buf.declaration, desc = 'LSP: [G]oto [D]eclaration', mode = 'n' },
      { 'grr', builtin.lsp_references, desc = 'LSP: [G]oto [R]eferences', mode = 'n' },
      { 'gri', builtin.lsp_implementations, desc = 'LSP: [G]oto [I]mplementation', mode = 'n' },
      { 'grd', builtin.lsp_definitions, desc = 'LSP: [G]oto [D]efinition', mode = 'n' },
      { 'grt', builtin.lsp_type_definitions, desc = 'LSP: [G]oto [T]ype Definition', mode = 'n' },
      { 'gO', builtin.lsp_document_symbols, desc = 'LSP: [O]pen Document Symbols', mode = 'n' },
      { 'gW', builtin.lsp_dynamic_workspace_symbols, desc = 'LSP: Open [W]orkspace Symbols', mode = 'n' },
    }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('n', '=f', vim.lsp.buf.format)

    -- Clean everything when done
    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('my-lsp-detach', { clear = true }),
      callback = vim.lsp.buf.clear_references
    })
  end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

-- LSP servers and clients are able to communicate to each other what features they support.
local blink = require 'blink.cmp'
local capabilities = blink.get_lsp_capabilities()
vim.lsp.config('*', { capabilities = capabilities })

-- Convenient keymap for Mason
vim.keymap.set('n', '<leader>m', '<cmd>Mason<CR>', { desc = 'Open [M]ason' })
