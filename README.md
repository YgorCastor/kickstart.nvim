# 🚀 Castor's Neovim Configuration

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

## Out-of-the-box Languages

1. Elixir
2. Rust
3. Go
4. Erlang
5. Gleam
6. C/C++ (clangd)
7. Helm
8. Java
9. JSON
10. Kotlin
11. Markdown
12. Python
13. Tailwind CSS
14. Terraform

## ✨ Installed Plugins

- 🔌 Plugin management with [lazy.nvim](https://github.com/folke/lazy.nvim)
- 🤖 AI Plugins:
  - [copilot.lua](https://github.com/zbirenbaum/copilot.lua) - GitHub Copilot integration
  - [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) - AI coding assistant
  - [mcphub.nvim](https://github.com/ravitemer/mcphub.nvim) - Model Context Protocol integration

- 🛠️ Editor Enhancements:
  - [arrow.nvim](https://github.com/otavioschwanck/arrow.nvim) - Navigate and bookmark files
  - [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlight and search TODO comments
  - [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding hints
  - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
  - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting and code navigation
  - [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) - Find and replace
  - [flash.nvim](https://github.com/folke/flash.nvim) - Enhanced motions
  - [ts-comments.nvim](https://github.com/folke/ts-comments.nvim) - Comment management
  - [mini.ai](https://github.com/echasnovski/mini.ai) - Better text objects
  - [yanky.nvim](https://github.com/gbprod/yanky.nvim) - Improved yank and paste
  - [workspaces.nvim](https://github.com/natecraddock/workspaces.nvim) - Project management
  - [overseer.nvim](https://github.com/stevearc/overseer.nvim) - Task runner

- 🖥️ UI Enhancements:
  - [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - File explorer
  - [mini.nvim](https://github.com/echasnovski/mini.nvim) - Collection of UI components
  - [nvim-terminal](https://github.com/s1n7ax/nvim-terminal) - Terminal integration
  - [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) - Git interface
  - [neotest](https://github.com/nvim-neotest/neotest) - Test runner
  - [persisted.nvim](https://github.com/olimorris/persisted.nvim) - Session management
  - [diffview.nvim](https://github.com/sindrets/diffview.nvim) - Git diff viewer
  - [codesnap.nvim](https://github.com/mistricky/codesnap.nvim) - Code screenshots
  - [lsp-lens.nvim](https://github.com/VidocqH/lsp-lens.nvim) - Code references/implementations counter
  - [snacks.nvim](https://github.com/folke/snacks.nvim) - UI notifications
  - [fidget.nvim](https://github.com/j-hui/fidget.nvim) - LSP progress notifications

- 🧩 LSP and Completion:
  - [mason.nvim](https://github.com/williamboman/mason.nvim) - Package manager
  - [conform.nvim](https://github.com/stevearc/conform.nvim) - Code formatter
  - [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) - Diagnostics, formatting, etc.
  - [blink.cmp](https://github.com/saghen/blink.cmp) - Autocompletion
  - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configuration
  - [trouble.nvim](https://github.com/folke/trouble.nvim) - Diagnostics viewer

- 🐛 Debugging:
  - [nvim-dap](https://github.com/mfussenegger/nvim-dap) - Debug Adapter Protocol
  - [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) - UI for DAP

- 💎 Language Specifit:
  - [crates.nvim](https://github.com/Saecki/crates.nvim) - Rust crates.io integration
  - [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) - Enhanced Rust development
  - [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) - Go debugging
  - [neotest-golang](https://github.com/fredrikaverpil/neotest-golang) - Go test adapter
  - [neotest-elixir](https://github.com/jfpedroza/neotest-elixir) - Elixir test adapter

## 📋 Requirements

- Neovim >= 0.11.0
- Git
- NodeJS NPM (for some plugins)
- Docker (Optional, but required by some MCPs)
- A [Nerd Font](https://www.nerdfonts.com/) (optional but recommended)
- [ripgrep](https://github.com/BurntSushi/ripgrep) for better search

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

## Out-of-Editor Configurations

### MCP Hub

MCP Hub is used to provide MCP Integration for this configuration, by default, it reads from ~/.mcpservers.json, i recommend this config:


```json
{
  "nativeMCPServers": [],
  "mcpServers": {
    "filesystem": {
      "disabled": true,
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/your/allowed/folders"
      ],
      "command": "npx"
    },
    "context7": {
      "disabled": false,
      "args": ["-y", "@upstash/context7-mcp@latest"],
      "command": "npx"
    },
    "tidewave_grain": {
    "kubernetes": {
      "disabled": true,
      "args": ["mcp-server-kubernetes"],
      "command": "npx"
    },
    "git": {
      "disabled": true,
      "args": [
        "run",
        "--rm",
        "-i",
        "--mount",
        "type=bind,src=/your/allowed/folder,dst=/your/allowed/folder",
        "mcp/git"
      ],
      "command": "docker"
    },
    "sequential-thinking": {
      "disabled": false,
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"],
      "command": "npx"
    },
    "playwright": {
      "disabled": false,
      "args": ["-y", "@executeautomation/playwright-mcp-server"],
      "command": "npx"
    },
    "knowledge_graph_memory": {
      "disabled": false,
      "args": ["-y", "@modelcontextprotocol/server-memory"],
      "env": {
        "MEMORY_FILE_PATH": "/folder/for/memory/.memory.json"
      },
      "command": "npx"
    },
    "hexdocs-mcp": {
      "command": "npx",
      "args": ["-y", "hexdocs-mcp@0.4.1"]
    },
    "github": {
      "disabled": true,
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR_PAT_TOKEN"
      },
      "command": "docker"
    }
  }
}
```

## Code Companion AI Configs

By default, CodeCompanion supports the following APIs:

* CoPilot
* Anthropic Claude
* Google Gemini
* OpenAI
* Hugging Face

### How to provide API Keys

The LLM API keys should be provided by putting a GPG encrypted file in the `~/.config/llms` folder. E.g:

Generate your key:

```bash
gpg --gen-key
```

Inside the llms folder, create a file with the apy key and encrypt it E.g:

```bash
gpg -e -r yourgpg@email.com huggingface
```

Done!

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


