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
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "nvim-lualine/lualine.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tabs<cr>", desc = "Find Help" },
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
		keys = {
			{ "<leader>g", "<cmd>Neogit<cr>", desc = "Open Git Window" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
	},
	{
		"stevearc/conform.nvim",
	},
})

---
-- Treesitter features
---
require("nvim-treesitter").install({
	"c",
	"css",
	"dockerfile",
	"erlang",
	"go",
	"gomod",
	"haskell",
	"hcl",
	"html",
	"javascript",
	"lua",
	"make",
	"markdown",
	"python",
	"query",
	"rust",
	"sql",
	"toml",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
})
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable treesitter features",
	pattern = "*",
	callback = function()
		pcall(vim.treesitter.start)
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
		vim.wo[0][0].foldenable = false
		pcall(function()
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end)
	end,
})

---
-- LSP setup
---
require("config.lsp")

---
-- Git Signs
---
require("config.gitsigns")

---
-- Lualine
---
require("lualine").setup()

---
-- Telescope
---
require("telescope").setup({
	extensions = {
		file_browser = {
			hijack_netrw = true,
		},
	},
})
require("telescope").load_extension("file_browser")

---
-- Conform Formatter
---
require("conform").setup({
	-- log_level = vim.log.levels.DEBUG,
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "oxfmt" },
		typescript = { "oxfmt" },
		typescriptreact = { "oxfmt" },
		html = { "oxfmt" },
		css = { "oxfmt" },
		yaml = { "oxfmt" },
		markdown = { "oxfmt" },
		go = { "goimports", "gofmt" },
		c = { "clang-format" },
		python = { "ruff_format" },
		haskell = { "ormolu" },
		rust = { "rustfmt" },
		terraform = { "terraform_fmt" },
		hcl = { "terragrunt_hclfmt" },
		erlang = { "erlfmt" },
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
})

---
-- Nvim Keybindings and Config
---
vim.cmd.colorscheme("catppuccin-mocha")

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

vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")

vim.keymap.set("n", "<leader>fp", ":Telescope file_browser<cr>")
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
