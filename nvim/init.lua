local o = vim.o
local wo = vim.wo
local opt = vim.opt
local g = vim.g -- vim global 

-- setup for neovide
if g.neovide then
	g.neovide_transparency = 1
	g.neovide_refresh_rate = 120
	g.neovide_cursor_animation_length = 0.1
	g.neovide_cursor_trail_size = 0.4
	g.neovide_remember_window_size = true
end

-- line number
wo.signcolumn = "no"
o.relativenumber = true
o.number = true

-- enable mouse
o.mouse = "a"
o.mousescroll = "ver:6,hor:6"


-- tabs
o.tabstop = 2
o.shiftwidth = 0
o.softtabstop = -1
o.expandtab = true

-- case sensitive search
o.ignorecase = true
o.smartcase = true

-- split screen
o.splitright = true
o.splitbelow = true

-- line break
o.linebreak = true
o.breakindent = true
o.wrap = false

-- popup menu
o.pumblend = 20
o.updatetime = 200

-- other stuff
o.guifont = "Menlo:h14"
o.swapfile = false
o.undofile = true
o.cursorline = false
o.list = true

-- vim.cmd("NoMatchParen")


-- plugin setup
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- plugin for neovide ui
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'projekt0n/github-nvim-theme'

-- coding plugin
Plug 'windwp/nvim-autopairs'
Plug 'nvim-tree/nvim-tree.lua'

-- code completion
Plug 'ycm-core/YouCompleteMe'

vim.call('plug#end')

-- auto pairs setup
require('nvim-autopairs').setup({
  disable_in_macro = true,
})

-- lualine setup
require('lualine').setup()

-- nvim tree setup
require('nvim-tree').setup({
  sort_by = "case_sensitive",
  view = {
    width = 40,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- colorscheme setup
vim.cmd('colorscheme github_light')

-- keybinding
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    option = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<C-;>", ":NvimTreeToggle<CR>", {silent = true})
map("n", "th", "<C-w>h")
map("n", "tj", "<C-w>j")
map("n", "tk", "<C-w>k")
map("n", "tl", "<C-w>l")

-- setup YouCompleteMe
g.ycm_show_diagnostics_ui = 0
vim.cmd [[ set completeopt-=preview ]]
