vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function() 
      require("neo-tree").setup()
    end,    
  },
  { 
    'rose-pine/neovim', 
    name = 'rose-pine',     
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "typescript" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files"},
      {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Text"},
      {"<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers"},
      {"<leader>fh", "<cmd>Telescope help_tabs<cr>", desc = "Find Help"}
    },
  } 
})

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

