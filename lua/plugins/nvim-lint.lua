-- Linting
return {
  'mfussenegger/nvim-lint',
  event = { 'BufEnter' },
  dependencies = {
    'j-hui/fidget.nvim',
    { 'mason-org/mason.nvim', opts = {} },
  },
  config = function()
    local lint = require 'lint'
    local linters_ft = require('mappings.linters')[vim.bo.filetype]
    if not linters_ft or #linters_ft == 0 then
      return
    end

    -- Discard uninstalled
    local installed = {}
    for _, linter in ipairs(linters_ft) do
      if vim.fn.executable(lint.linters[linter].cmd) == 1 then
        table.insert(installed, linter)
      end
    end

    -- Discard if condition false
    local lintersconf = require 'config.linters'
    local ctx = { filename = vim.api.nvim_buf_get_name(0) }
    ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
    local to_load = {}
    for _, linter in ipairs(installed) do
      if not lintersconf[linter] then
        table.insert(to_load, linter)
      elseif not lintersconf[linter].condition then
        table.insert(to_load, linter)
      elseif lintersconf[linter].condition(ctx) then
        table.insert(to_load, linter)
      end
    end

    -- Merge our configs with the defaults
    for _, linter in ipairs(to_load) do
      if lintersconf[linter] and lintersconf[linter].pre_args then
        vim.list_extend(lint.linters[linter].args, lintersconf[linter].pre_args)
      end
    end

    -- Warn just in case
    if #to_load > 1 then
      require('fidget').notify(string.format('%d %s linters loaded', #to_load, vim.bo.filetype), vim.log.levels.WARN)
    end

    -- Create the cmd to run it
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('my-lint', { clear = true }),
      callback = function()
        -- Only run the linter in buffers that you can modify in order to
        -- avoid superfluous noise, notably within the handy LSP pop-ups that
        -- describe the hovered symbol using Markdown.
        if vim.bo.modifiable then
          lint.try_lint(to_load, { ignore_errors = true })
        end
      end,
    })
  end,
}
