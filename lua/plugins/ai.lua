return {
  {
    'joshuavial/aider.nvim',
    opts = {
      auto_manage_context = true,
      default_bindings = false,
      debug = false,
    },
    event = 'VeryLazy',
    config = function()
      require('aider').setup {
        vim.api.nvim_set_keymap('n', '<leader>Ais', ':AiderOpen --model sonnet --subtree-only --cache-prompts<CR>', { noremap = true, silent = true }),
        vim.api.nvim_set_keymap('n', '<leader>Aio3', ':AiderOpen --model o3-mini --subtree-only --cache-prompts<CR>', { noremap = true, silent = true }),
        vim.api.nvim_set_keymap('n', '<leader>Aig', ':AiderOpen --model  gemini-2.5-pro --subtree-only<CR>', { noremap = true, silent = true }),
      }
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<leader>Ais',  desc = 'Open aider with Sonnet',  mode = 'n' },
        { '<leader>Aio3', desc = 'Open aider with o3-mini', mode = 'n' },
        { '<leader>Aig',  desc = 'Open aider with gemini',  mode = 'n' },
      },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    config = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'ravitemer/mcphub.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'npm install -g mcp-hub@latest',
    config = function()
      require('mcphub').setup {
        port = 3000,
        config = vim.fn.expand '~/.mcpservers.json',
      }

      require('codecompanion').setup {
        strategies = {
          chat = {
            tools = {
              ['mcp'] = {
                callback = require 'mcphub.extensions.codecompanion',
                description = 'Call tools and resources from the MCP Servers',
                opts = {
                  requires_approval = true,
                },
              },
            },
          },
        },
      }
    end,
  },
}
