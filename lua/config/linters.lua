return {
  -- Lua
  selene = {
    condition = function(ctx)
      return vim.fs.find({ 'selene.toml' }, { path = ctx.filename, upward = true })[1]
    end,
  },
}
