# 🚀 Castor's Neovim Configuration

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

## ✨ Features

- 🔌 Plugin management with [lazy.nvim](https://github.com/folke/lazy.nvim)
- 🧠 AI assistance with:
  - [Aider](https://github.com/joshuavial/aider.nvim) for AI-powered coding
  - [GitHub Copilot](https://github.com/zbirenbaum/copilot.lua) integration
  - [CodeCompanion](https://github.com/olimorris/codecompanion.nvim) for AI chat
  - [MCP Hub](https://github.com/ravitemer/mcphub.nvim) integration
- 🎨 Multiple themes with easy switching via [Themery](https://github.com/zaldih/themery.nvim)
- 📝 LSP setup with:
  - Autocompletion via [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
  - Formatting with [conform.nvim](https://github.com/stevearc/conform.nvim)
  - Diagnostics visualization with [Trouble](https://github.com/folke/trouble.nvim)
- 🔍 Powerful search with [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- 📊 Syntax highlighting with [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- 📌 Bookmark files with [Arrow](https://github.com/otavioschwanck/arrow.nvim)
- 📋 Enhanced clipboard with [Yanky](https://github.com/gbprod/yanky.nvim)
- 🔄 Project management with [Workspaces](https://github.com/natecraddock/workspaces.nvim)
- ⚡ Fast navigation with [Flash](https://github.com/folke/flash.nvim)

## 📋 Requirements

- Neovim >= 0.9.0 (0.10.0 recommended for full feature support)
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (optional but recommended)
- [ripgrep](https://github.com/BurntSushi/ripgrep) for better search
- Language servers for your preferred languages

## 🚀 Installation

### Backup your existing configuration

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

### Clone this repository

```bash
git clone https://github.com/ygorcastor/kickstart.nvim ~/.config/nvim
```

### Start Neovim

```bash
nvim
```

On first launch, the configuration will automatically install lazy.nvim and all plugins.

## ⌨️ Key Mappings

The leader key is set to `<Space>`.

### General

- `<Space>` - Leader key
- `<Esc>` - Clear search highlights
- `<C-h/j/k/l>` - Navigate between windows

### LSP

- `gd` - Go to definition
- `gr` - Go to references
- `gI` - Go to implementation
- `<leader>D` - Type definition
- `<leader>rn` - Rename
- `<leader>ca` - Code action

### Telescope

- `<leader>ff` - Find files
- `<leader>fr` - Recent files
- `<leader>fb` - Buffers
- `<leader><leader>` - Live grep (search in all files)
- `<leader>/` - Search in current buffer

### Formatting

- `<leader>cf` - Format buffer

### Navigation

- `s` - Flash (quick navigation)
- `S` - Flash Treesitter

## 🎨 Themes

This configuration includes several themes:

- Flow
- Monochrome
- Melange
- Zenburn
- Obscure
- Bamboo
- Lackluster

Use `:Themery` to switch between themes.

## 🔧 Customization

### Adding new plugins

Edit the appropriate file in `lua/plugins/` directory and add your plugin configuration following the lazy.nvim format.

### Changing options

Edit `lua/core/options.lua` to change Neovim options.

### Modifying key mappings

Edit `lua/core/keymaps.lua` to change key mappings.

## 🔄 Updating

To update all plugins:

1. Open Neovim
2. Run `:Lazy update`

## 📝 License

This project is licensed under the terms of the MIT license.
