return {
  -- Lua
  lua_ls = {
    settings = {
      Lua = { completion = { callSnippet = 'Replace' } },
    },
  },
  -- Fortran
  fortls = {
    cmd = {
      'fortls',
      '--hover_signature',
      '--hover_language=fortran',
      '--use_signature_help',
      '--lowercase_intrinsics',
    },
  },
  -- Python
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { 'E402' },
          },
        },
      },
    },
  },
}
