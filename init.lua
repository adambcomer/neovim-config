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
  { 'nvim-lualine/lualine.nvim' },
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
  { "catppuccin/nvim",                  name = "catppuccin", priority = 1000 },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "css", "typescript", "go", "markdown" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Find Text" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tabs<cr>",  desc = "Find Help" }
    },
  },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    }
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true,
    keys = {
      { "<leader>g", "<cmd>Neogit<cr>", desc = "Open Git Window" }
    }
  },
  {
    "lewis6991/gitsigns.nvim"
  }
})

---
-- LSP setup
---
require('config.lsp')

---
-- Git Signs
---
require("config.gitsigns")

---
-- Lualine
---
require('lualine').setup()

---
-- Nvim Keybindings and Config
---
vim.cmd.colorscheme "catppuccin-mocha"

vim.opt.termguicolors = true

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

vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- Window Navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
