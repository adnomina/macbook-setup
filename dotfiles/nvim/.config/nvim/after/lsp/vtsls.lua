return {
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      enableMoveToFileCodeAction = true,
    },
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = { completeFunctionCalls = true },
      inlayHints = {
        parameterNames = { enabled = 'literals' },
        functionLikeReturnTypes = { enabled = true },
      },
    },
    javascript = {
      updateImportsOnFileMove = { enabled = 'always' },
    },
  },
}
