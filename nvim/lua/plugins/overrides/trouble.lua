-- Change configuration for trouble.nvim

return {
  -- Plugin: trouble.nvim
  -- URL: https://github.com/folke/trouble.nvim
  -- Description: A pretty list for showing diagnostics, references, telescope results, quickfix and location lists.
  "folke/trouble.nvim",
  -- Options to be merged with the parent specification
  opts = {
    use_diagnostic_signs = false, -- Use diagnostic signs for trouble.nvim
    auto_close = true,
    auto_jump = true,
  },
}
