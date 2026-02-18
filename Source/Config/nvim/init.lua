-- --- 🚀 https://github.com/sparshabhusal ✨ --- --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-------------------------------
--  Plugins
-------------------------------
require("lazy").setup({

  -- Catppuccin Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter = true,
          telescope = true,
          lualine = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Lualine (Statusline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
          lualine_x = {}, -- empty = no icons on right
          lualine_y = {},
          lualine_z = { "location" },
        },
      })
    end,
  },

})


-------------------------------
--  Neovim Settings
-------------------------------

-- Show line numbers
vim.opt.number = true

-- Remove "~" on empty lines
vim.opt.fillchars = {
  eob = " ",
}

-- Disable Neovim startup intro
vim.opt.shortmess:append("I")

-- Side Fixes
vim.opt.termguicolors = true
vim.opt.linespace = 0

-- Transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })


