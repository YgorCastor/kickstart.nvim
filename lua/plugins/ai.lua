return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      vim.g.copilot_settings = { selectedCompletionModel = 'gpt-5-copilot' }
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
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        copilot = {},
      },
    },
  },
  {
    'folke/sidekick.nvim',
    opts = {
      cli = {
        mux = {
          backend = 'zellij',
          enabled = true,
        },
      },
    },
    keys = {
      {
        '<c-.>',
        function()
          require('sidekick.cli').focus()
        end,
        mode = { 'n', 'x', 'i', 't' },
        desc = 'Sidekick Switch Focus',
      },
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle { focus = true }
        end,
        desc = 'Sidekick Toggle CLI',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ac',
        function()
          require('sidekick.cli').toggle { name = 'claude', focus = true }
        end,
        desc = 'Sidekick Claude Toggle',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').select_prompt()
        end,
        desc = 'Sidekick Ask Prompt',
        mode = { 'n', 'v' },
      },
    },
  },
}
