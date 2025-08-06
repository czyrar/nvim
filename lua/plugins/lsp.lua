-- LSP protocol
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Mason takes care of installation of servers
    { 'mason-org/mason.nvim',           opts = {} },
    { 'mason-org/mason-lspconfig.nvim', opts = {} },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },
    -- Allows extra capabilities provided by blink.cmp
    'saghen/blink.cmp',
    'folke/which-key.nvim',
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
      callback = function()
        local builtin = require('telescope.builtin')
        require('which-key').add {
          { 'gr',  group = 'LSP: [G]oto',                 mode = 'n' },
          { 'grn', vim.lsp.buf.rename,                    desc = 'LSP: [R]e[n]ame',               mode = 'n' },
          { 'gra', vim.lsp.buf.code_action,               desc = 'LSP: [G]oto Code [A]ction',     mode = { 'n', 'x' } },
          { 'grD', vim.lsp.buf.declaration,               desc = 'LSP: [G]oto [D]eclaration',     mode = 'n' },
          { 'grr', builtin.lsp_references,                desc = 'LSP: [G]oto [R]eferences',      mode = 'n' },
          { 'gri', builtin.lsp_implementations,           desc = 'LSP: [G]oto [I]mplementation',  mode = 'n' },
          { 'grd', builtin.lsp_definitions,               desc = 'LSP: [G]oto [D]efinition',      mode = 'n' },
          { 'grt', builtin.lsp_type_definitions,          desc = 'LSP: [G]oto [T]ype Definition', mode = 'n' },
          { 'gO',  builtin.lsp_document_symbols,          desc = 'LSP: [O]pen Document Symbols',  mode = 'n' },
          { 'gW',  builtin.lsp_dynamic_workspace_symbols, desc = 'LSP: Open [W]orkspace Symbols', mode = 'n' },
          { '=f',  vim.lsp.buf.format,                    desc = 'LSP: [F]ormat file',            mode = 'n' },
        }

        -- Clean everything when done
        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('my-lsp-detach', { clear = true }),
          callback = function()
            vim.lsp.buf.clear_references()
          end
        })
      end
    })

    -- Diagnostic Config
    -- See :help vim.diagnostic.Opts
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
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
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Bug with julials in Mason...
    vim.lsp.config('julials', {})
    vim.lsp.enable('julials')

    -- Enable the lua language server
    -- If custom configs for some server are needed add them as keys
    local servers = {
      lua_ls = {},
      stylua = {},
    }
    require('mason-tool-installer').setup { ensure_installed = servers }
    require('mason-lspconfig').setup {
      ensure_installed = {}, -- explicitly set to an empty table
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          vim.lsp.enable(server_name)
        end,
      },
    }
  end,
}
