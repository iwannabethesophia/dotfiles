local o = vim.o
local wo = vim.wo
local opt = vim.opt
local g = vim.g -- vim global 

-- setup for neovide
if g.neovide then
  g.neovide_transparency = 1
  g.neovide_cursor_animation_length = 0.09
  g.neovide_cursor_trail_size = 0.4
  g.neovide_remember_window_size = true
  vim.cmd [[ set t_Co=256 ]]
end

-- line number
wo.signcolumn = "no"
-- o.relativenumber = true
-- o.number = true

-- enable mouse
o.mouse = "a"
o.mousescroll = "ver:8,hor:8"

-- clipboard
o.clipboard = "unnamed"

-- tabs
o.tabstop = 2
o.shiftwidth = 0
o.softtabstop = -1
o.expandtab = true
--o.linespace = 3

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
o.updatetime = 50

-- other stuff
o.guifont = "Roboto_Mono_for_Powerline:h11"
--o.guifont = "Fixedsys:h15"
o.swapfile = false
o.undofile = true
o.cursorline = true
o.list = true

vim.cmd [[
set nu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END
]]

-- plugin setup
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- plugin for neovide ui
if g.neovide then
  Plug 'nvim-lualine/lualine.nvim'
else
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
end
Plug 'nvim-tree/nvim-web-devicons'
Plug 'projekt0n/github-nvim-theme'
Plug 'Mofiqul/vscode.nvim'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

-- coding plugin
Plug 'windwp/nvim-autopairs'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'neoclide/vim-jsx-improve'
Plug('codota/tabnine-nvim', {['do'] = './dl_binaries.sh'})

-- code completion
Plug('neoclide/coc.nvim', {['branch'] = 'release'})
Plug 'tpope/vim-rails'

vim.call('plug#end')


-- auto pairs setup
require('nvim-autopairs').setup({
  disable_in_macro = true,
})

-- lualine setup
if g.neovide then
  require('lualine').setup({
    options = {
      theme = 'vscode'
    },
  })
end

-- setup for neovide
if g.neovide then
  -- setup for competitive programming colorscheme like gvim on window
  --vim.cmd [[ hi Normal     guifg=#000000 guibg=#ffffff ]]
  --vim.cmd [[ hi NonText    guifg=#ffffff ]]
  --vim.cmd [[ hi LineNr     guifg=#9f403e ]]
  --vim.cmd [[ hi String     guifg=#d94ed3 ]]
  --vim.cmd [[ hi Special    guifg=#6c66b0 ]]
  --vim.cmd [[ hi Constant   guifg=#d94ed3 ]]
  --vim.cmd [[ hi PreProc    guifg=#a73fee ]]
  --vim.cmd [[ hi Type       guifg=#3f8568 ]]
  --vim.cmd [[ hi Statement  guifg=#a9352f ]]
  --vim.cmd [[ hi Pmenu      guifg=#0084ff ]]
  --vim.cmd [[ hi MatchParen guibg=#09d7e8 ]]
  --vim.cmd [[ hi Visual     guibg=#09d7e8 ]]

  --vim.cmd('colorscheme github_light')
else
  o.background = "light"
  vim.cmd('colorscheme solarized')
  g.airline_theme = 'solarized'
end

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
    dotfiles = false,
  },
})

vim.cmd[[
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
]]
-- setup for coc-pug
g.coc_filetype_map = {
  ['pug'] = 'jade'
}

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
map("n", "<C-t>", ":Files ~/Desktop/contest/Templates<CR>")
map("n", "G", "G$")
map("n", "gg", "gg^")

map("v", "G", "G$")
map("v", "gg", "gg^")

-- setup YouCompleteMe
--g.ycm_show_diagnostics_ui = 0
vim.cmd [[ set completeopt-=preview ]]

-- vscode theme setup
o.background = 'dark'
local c = require('vscode.colors').get_colors()
require('vscode').setup({
  transparent = false,
  italic_comments = false,
  group_overrides = {
    Cursor = {fg = c.vscDarkBlue, bg=c.vscLightGreen, bold=true}
  }
})
require('vscode').load()

-- tabnine support for neovide
if g.neovide then
  require('tabnine').setup({
    disable_auto_comment=true,
    accept_keymap = "<Tab>",
    dismiss_keymap = "<C-]>",
    debounce_time = 500,
    suggestion_color = {gui = "#8f8f8f", cterm = 244},
    exclude_filetypes = {"TelescopePrompt", "NvimTree"},
    log_file_path = nil,
  })
  require('tabnine.status').status()
end

