-- Allow to understand nodes and childs from languages.
-- This permits better textobjects, show context, highlights and indent.
-- Configured to autoinstall languages.
local noinstall = {}
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    -- Ensure we have for the documentation
    require('nvim-treesitter').install({ 'lua', 'luadoc' })

    -- Auto install
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter.setup', {}),
      callback = function(args)
        local buf = args.buf
        local filetype = args.match
        local language = vim.treesitter.language.get_lang(filetype) or filetype
        if noinstall[noinstall] ~= nil then
          return
        end
        if not vim.treesitter.language.add(language) then
          return
        end
        vim.treesitter.start(buf, language)
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
