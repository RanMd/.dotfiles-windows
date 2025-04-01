-- This file contains the configuration for disabling specific Neovim plugins.

return {
  {
    -- Plugin: bufferline.nvim
    -- URL: https://github.com/akinsho/bufferline.nvim
    -- Description: A snazzy buffer line (with tabpage integration) for Neovim.
    "dinhhuy258/git.nvim",
    enabled = true, -- Disable this plugin
  },
  {
    -- Plugin: bufferline.nvim
    -- URL: https://github.com/akinsho/bufferline.nvim
    -- Description: A snazzy buffer line (with tabpage integration) for Neovim.
    "akinsho/bufferline.nvim",
    enabled = false, -- Disable this plugin
  },
  {
    "ibhagwan/fzf-lua",
    enabled = false,
  },
  {
    "echasnovski/mini.icons",
    enabled = true,
  },
  {
    "RanMd/winbar.nvim",
    enabled = true,
  },
  {
    "b0o/incline.nvim",
    enabled = false,
  },
}
