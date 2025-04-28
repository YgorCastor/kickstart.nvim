return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        copilot_model = 'gemini-2.5-pro',
      }
    end,
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
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      { '<leader>ccc', '<cmd>CodeCompanionChat<cr>',      desc = 'Start CodeCompanionChat' },
      { '<leader>cce', '<cmd>CodeCompanion /explain<cr>', desc = 'Explain current snippet' },
    },
    config = function()
      require('codecompanion').setup {
        adapters = {
          openai = function()
            return require('codecompanion.adapters').extend('openai', {
              schema = {
                model = {
                  default = 'gpt-4.1',
                },
              },
            })
          end,
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = 'gemini-2.5-pro',
                },
              },
            })
          end,
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              schema = {
                model = {
                  default = 'clause-3.7-sonnet',
                },
              },
            })
          end,
        },
      }
    end,
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
