-- Git integration
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        require('which-key').add({ '<leader>g', group = '[G]it Hunk' })

        -- Navigation
        map('n', ']h', function()
          gitsigns.nav_hunk('next')
        end, { desc = 'Previous Hunk' })
        map('n', '[h', function()
          gitsigns.nav_hunk('prev')
        end, { desc = 'Next Hunk' })

        -- Actions
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[G]it Hunk [S]tage' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[G]it Hunk [R]eset' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[G]it Hunk [P]review' })
        map('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it Hunk [D]iff' })

        -- Text object
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
      end
    }
  end
}
