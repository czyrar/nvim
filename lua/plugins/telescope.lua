-- Fuzzy finder for everything
return {
  'nvim-telescope/telescope.nvim',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    'nvim-treesitter/nvim-treesitter',
    'folke/which-key.nvim',
  },
  event = 'VeryLazy',
  config = function()
    -- Enable Telescope extensions
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {},
        },
        fzf = {},
      },
    }
    require('telescope').load_extension 'ui-select' -- Modify aspects
    require('telescope').load_extension 'fzf' -- Better search (fuzzy find)

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    require('which-key').add {
      { '<leader>s', group = '[S]earch', mode = 'n' },
      { '<leader>sh', builtin.help_tags, desc = '[S]earch [H]elp', mode = 'n' },
      { '<leader>sk', builtin.keymaps, desc = '[S]earch [K]eymaps', mode = 'n' },
      { '<leader>sf', builtin.find_files, desc = '[S]earch [F]iles', mode = 'n' },
      { '<leader>ss', builtin.builtin, desc = '[S]earch [S]elect Telescope', mode = 'n' },
      { '<leader>sw', builtin.grep_string, desc = '[S]earch current [W]ord', mode = 'n' },
      { '<leader>sg', builtin.live_grep, desc = '[S]earch by [G]rep', mode = 'n' },
      { '<leader>sd', builtin.diagnostics, desc = '[S]earch [D]iagnostics', mode = 'n' },
      { '<leader>sr', builtin.resume, desc = '[S]earch [R]esume', mode = 'n' },
      { '<leader>s.', builtin.oldfiles, desc = '[S]earch Recent Files', mode = 'n' },
      {
        '<leader>s/',
        function()
          builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
        end,
        desc = '[S]earch in Open Files',
        mode = 'n',
      },
      {
        '<leader>sn',
        function()
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = '[S]earch [N]eovim files',
        mode = 'n',
      },
    }

    -- fzf all buffers
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

    -- fzf current buffer
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
    end, { desc = 'Search in current buffer' })
  end,
}
