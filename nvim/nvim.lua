vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- plugin
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'Shatur/neovim-ayu'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ayu-theme/ayu-vim-airline'
-- Plug 'powerline/powerline'
-- Plug 'nvim-lualine/lualine.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-neo-tree/neo-tree.nvim'

-- depenencies
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'

-- code plugin
--Plug 'ycm-core/YouCompleteMe'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'Shougo/neoinclude.vim'
Plug 'norcalli/nvim-colorizer.lua'
-- Plug 'jsfaint/coc-neoinclude'
-- Plug('neoclide/coc.nvim', { branch = 'release' })
-- Plug 'Maxattax97/coc-ccls'
Plug 'sheerun/vim-polyglot'

vim.call('plug#end')

-- general settings
vim.cmd([[
	filetype plugin indent on
	syntax on
]])
vim.opt.fileencoding = 'utf-8'
vim.opt.swapfile = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt.wrap = false

vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.nu = true
vim.opt.termguicolors = false
vim.cmd [[ set t_Co=256 ]]
-- rnu toggle
vim.cmd([[
	augroup NumberToggle
		autocmd!
		autocmd BufEnter,FocusGained,InsertLeave * set rnu
		autocmd BufLeave,FocusLost,InsertEnter * set nornu
	augroup END
]])
vim.opt.updatetime = 100

-- vim.opt.cursorline = true
vim.opt.laststatus = 2
-- vim.opt.showtabline = 2
vim.opt.signcolumn = 'no'

-- keymap settings
vim.keymap.set('n', ';h', '<C-w>h')
vim.keymap.set('n', ';j', '<C-w>j')
vim.keymap.set('n', ';k', '<C-w>k')
vim.keymap.set('n', ';l', '<C-w>l')
-- [[ keymap setting ]] --
vim.keymap.set('n', '<Tab>', ':Neotree<CR>')

-- lualine config
--[[
require('lualine').setup({
	option = {
		icons_enabled = true,
		theme = 'ayu-light',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'filetype', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'diagnostics', 'progress', 'encoding' },
		lualine_y = {  },
		lualine_z = { '%-l/%l lines' },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
]]--

vim.cmd [[ set completeopt-=preview ]]

-- [[ airline config ]] --
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = "ayu_dark"
vim.cmd [[ let g:airline#extensions#whitespace#enabled = 0 ]]

-- neo-tree setup
require("neo-tree").setup({
	close_if_last_window = false,
	enable_diagnostics = true,
	enable_git_status = true,
	popup_border_style = "rounded",
	sort_case_insensitive = false,
		filesystem = {
			filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
	window = { width = 35 },
})
