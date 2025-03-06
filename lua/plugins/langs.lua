return {
  {
    'nvim-neotest/neotest',
    lazy = true,
    event = 'VeryLazy',
    optional = true,
    dependencies = {
      'jfpedroza/neotest-elixir',
    },
    opts = {
      adapters = {
        ['neotest-elixir'] = {},
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    event = 'LazyFile',
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = {
        elixir = { 'credo' },
      }

      opts.linters = {
        credo = {
          condition = function(ctx)
            return vim.fs.find({ '.credo.exs' }, { path = ctx.filename, upward = true })[1]
          end,
        },
      }
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    opts = function(_, opts)
      local nls = require 'null-ls'
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.mix.with {
          cwd = function()
            -- Use Neovim's current working directory
            return vim.fn.getcwd()
          end,
          extra_args = function()
            local cwd = vim.fn.getcwd()
            local formatter_path = cwd .. '/.formatter.exs'

            if vim.fn.filereadable(formatter_path) == 1 then
              return { '--dot-formatter', formatter_path }
            end
            return {}
          end,
        },
      })
    end,
  },
}
