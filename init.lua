vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Load core modules
require('core.options')
require('core.keymaps')
require('core.autocmds')

-- Load plugin configuration
require('config.lazy_setup')
