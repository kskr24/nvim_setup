require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()
vim.opt.clipboard = 'unnamedplus'
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
vim.opt.shiftwidth=4
vim.opt.tabstop=4
vim.opt.expandtab=true
-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
-- Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug('junegunn/vim-easy-align')
-- Any valid git URL is allowed
Plug('https://github.com/junegunn/vim-github-dashboard.git')

-- Multiple Plug commands can be written in a single line using ; separators
Plug('SirVer/ultisnips'); Plug('honza/vim-snippets')

-- On-demand loading
Plug('tpope/vim-fireplace', { ['for'] = 'clojure' })

-- Using a non-default branch
Plug('rdnetto/YCM-Generator', { ['branch'] = 'stable' })

-- Plugin outside ~/.vim/plugged with post-update hook
Plug('junegunn/fzf', { ['dir'] = '~/.fzf', ['do'] = './install --all' })

-- Unmanaged plugin (manually installed and updated)
Plug('~/my-prototype-plugin')

vim.call('plug#end')
