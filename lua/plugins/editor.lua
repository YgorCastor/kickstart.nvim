return {
  {
    'otavioschwanck/arrow.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    lazy = true,
    event = 'VeryLazy',
    keys = {
      {
        '<leader>H',
        function()
          require('arrow.ui').toggle_quick_menu()
        end,
        desc = 'Arrow Toggle',
      },
    },
    opts = {
      show_icons = true,
      leader_key = '<leader>H', -- We're setting this to match our keybinding
      buffer_leader_key = 'm', -- Per Buffer Mappings
      separate_by_branch = true,
      hide_handbook = false,
    },
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 500,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>H', group = 'Arrow' },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'css',
        'diff',
        'elixir',
        'erlang',
        'helm',
        'html',
        'json',
        'kotlin',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'rust',
        'vim',
        'vimdoc',
        'yaml',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    event = 'VeryLazy',
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>sr',
        function()
          local grug = require 'grug-far'
          local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          }
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace',
      },
    },
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    vscode = true,
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'o', 'x' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  {
    'folke/flash.nvim',
    optional = true,
    specs = {
      {
        'folke/snacks.nvim',
        opts = {
          picker = {
            win = {
              input = {
                keys = {
                  ['<a-s>'] = { 'flash', mode = { 'n', 'i' } },
                  ['s'] = { 'flash' },
                },
              },
            },
            actions = {
              flash = function(picker)
                require('flash').jump {
                  pattern = '^',
                  label = { after = { 0, 0 } },
                  search = {
                    mode = 'search',
                    exclude = {
                      function(win)
                        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'snacks_picker_list'
                      end,
                    },
                  },
                  action = function(match)
                    local idx = picker.list:row2idx(match.pos[1])
                    picker.list:_move(idx, true, true)
                  end,
                }
              end,
            },
          },
        },
      },
    },
  },
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has 'nvim-0.10.0' == 1,
  },
  { 'echasnovski/mini.ai', version = '*' },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    event = 'LazyFile',
    opts = {
      -- Event to trigger linters
      events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
      linters_by_ft = {
        fish = { 'fish' },
      },
      ---@type table<string,table>
      linters = {
        -- -- Example of using selene only when a selene.toml file is present
        -- selene = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
      },
    },
    config = function(_, opts)
      local M = {}

      local lint = require 'lint'
      for name, linter in pairs(opts.linters) do
        if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
          lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], linter)
          if type(linter.prepend_args) == 'table' then
            lint.linters[name].args = lint.linters[name].args or {}
            vim.list_extend(lint.linters[name].args, linter.prepend_args)
          end
        else
          lint.linters[name] = linter
        end
      end
      lint.linters_by_ft = opts.linters_by_ft

      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function M.lint()
        -- Use nvim-lint's logic first:
        -- * checks if linters exist for the full filetype first
        -- * otherwise will split filetype by "." and add all those linters
        -- * this differs from conform.nvim which only uses the first filetype that has a formatter
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        -- Create a copy of the names table to avoid modifying the original.
        names = vim.list_extend({}, names)

        -- Add fallback linters.
        if #names == 0 then
          vim.list_extend(names, lint.linters_by_ft['_'] or {})
        end

        -- Add global linters.
        vim.list_extend(names, lint.linters_by_ft['*'] or {})

        -- Filter out linters that don't exist or don't match the condition.
        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          return linter and not (type(linter) == 'table' and linter.condition and not linter.condition(ctx))
        end, names)

        -- Run linters.
        if #names > 0 then
          lint.try_lint(names)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = M.debounce(100, M.lint),
      })
    end,
  },
  {
    'gbprod/yanky.nvim',
    dependencies = {
      { 'kkharji/sqlite.lua' },
    },
    opts = {
      ring = { storage = 'sqlite' },
    },
    keys = {
      {
        '<leader>p',
        function()
          require('telescope').extensions.yank_history.yank_history {}
        end,
        desc = 'Open Yank History',
      },
      {
        'y',
        '<Plug>(YankyYank)',
        mode = { 'n', 'x' },
        desc = 'Yank text',
      },
      {
        'p',
        '<Plug>(YankyPutAfter)',
        mode = { 'n', 'x' },
        desc = 'Put yanked text after cursor',
      },
      {
        'P',
        '<Plug>(YankyPutBefore)',
        mode = { 'n', 'x' },
        desc = 'Put yanked text before cursor',
      },
      {
        'gp',
        '<Plug>(YankyGPutAfter)',
        mode = { 'n', 'x' },
        desc = 'Put yanked text after selection',
      },
      {
        'gP',
        '<Plug>(YankyGPutBefore)',
        mode = { 'n', 'x' },
        desc = 'Put yanked text before selection',
      },
      { '<c-p>', '<Plug>(YankyPreviousEntry)', desc = 'Select previous entry through yank history' },
      { '<c-n>', '<Plug>(YankyNextEntry)', desc = 'Select next entry through yank history' },
      { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
      { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
      { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
      { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
      { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', desc = 'Put and indent right' },
      { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', desc = 'Put and indent left' },
      { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'Put before and indent right' },
      { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', desc = 'Put before and indent left' },
      { '=p', '<Plug>(YankyPutAfterFilter)', desc = 'Put after applying a filter' },
      { '=P', '<Plug>(YankyPutBeforeFilter)', desc = 'Put before applying a filter' },
    },
  },
  {
    'natecraddock/workspaces.nvim',
    lazy = true,
    cmd = { 'WorkspacesAdd', 'WorkspacesRemove', 'WorkspacesList' },
    keys = {
      { '<leader>wa', '<cmd>WorkspacesAdd<cr>', desc = 'Add Workspace' },
      { '<leader>wr', '<cmd>WorkspacesRemove<cr>', desc = 'Add Workspace' },
      { '<leader>wl', '<cmd>WorkspacesList<cr>', desc = 'List Workspaces' },
    },
    config = function()
      require('workspaces').setup()
    end,
  },
  {
    'stevearc/overseer.nvim',
    cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerSaveBundle',
      'OverseerLoadBundle',
      'OverseerDeleteBundle',
      'OverseerRunCmd',
      'OverseerRun',
      'OverseerInfo',
      'OverseerBuild',
      'OverseerQuickAction',
      'OverseerTaskAction',
      'OverseerClearCache',
    },
    opts = {
      dap = false,
      task_list = {
        bindings = {
          ['<C-h>'] = false,
          ['<C-j>'] = false,
          ['<C-k>'] = false,
          ['<C-l>'] = false,
        },
      },
      form = {
        win_opts = {
          winblend = 0,
        },
      },
      confirm = {
        win_opts = {
          winblend = 0,
        },
      },
      task_win = {
        win_opts = {
          winblend = 0,
        },
      },
    },
    keys = {
      { '<leader>ow', '<cmd>OverseerToggle<cr>', desc = 'Task list' },
      { '<leader>oo', '<cmd>OverseerRun<cr>', desc = 'Run task' },
      { '<leader>oq', '<cmd>OverseerQuickAction<cr>', desc = 'Action recent task' },
      { '<leader>oi', '<cmd>OverseerInfo<cr>', desc = 'Overseer Info' },
      { '<leader>ob', '<cmd>OverseerBuild<cr>', desc = 'Task builder' },
      { '<leader>ot', '<cmd>OverseerTaskAction<cr>', desc = 'Task action' },
      { '<leader>oc', '<cmd>OverseerClearCache<cr>', desc = 'Clear cache' },
    },
  },
  {
    'nvim-focus/focus.nvim',
    version = '*',
    config = function()
      require('focus').setup()
    end,
    keys = {
      { '<leader>su', '<cmd>FocusSplitUp<cr>', desc = 'Split Up' },
      { '<leader>sj', '<cmd>FocusSplitDown<cr>', desc = 'Split Down' },
      { '<leader>sh', '<cmd>FocusSplitLeft<cr>', desc = 'Split Left' },
      { '<leader>sl', '<cmd>FocusSplitRight<cr>', desc = 'Split Right' },
      { '<leader>sg', '<cmd>FocusSplitNicely<cr>', desc = 'Split Based on Golden Ratio' },
      { '<leader>ntd', '<cmd>FocusSplitDown cmd term<cr>', desc = 'Split Term Down' },
      { '<leader>fm', '<cmd>FocusMaximise<cr>', desc = 'Maximise Current Focus' },
    },
  },
  {
    's1n7ax/nvim-terminal',
    event = 'VeryLazy',
    config = function()
      vim.o.hidden = true
      require('nvim-terminal').setup {
        disable_default_keymaps = true,
      }
    end,
    keys = {
      { '<leader>tt', ':lua NTGlobal["terminal"]:toggle()<cr>', desc = 'Toggle Terminal' },
      { '<leader>t1', ':lua NTGlobal["terminal"]:open(1)<cr>', desc = 'Toggle Terminal 1' },
      { '<leader>t2', ':lua NTGlobal["terminal"]:open(2)<cr>', desc = 'Toggle Terminal 2' },
      { '<leader>t3', ':lua NTGlobal["terminal"]:open(3)<cr>', desc = 'Toggle Terminal 3' },
      { '<leader>t4', ':lua NTGlobal["terminal"]:open(4)<cr>', desc = 'Toggle Terminal 4' },
      { '<leader>t5', ':lua NTGlobal["terminal"]:open(5)<cr>', desc = 'Toggle Terminal 5' },
    },
  },
  {
    'folke/snacks.nvim',
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ['<a-c>'] = {
                'toggle_cwd',
                mode = { 'n', 'i' },
              },
            },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      -- find
      { "<leader>sff", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
      { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Recent (cwd)" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      -- search
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<space><space>", function() Snacks.picker.grep() end, desc = "Grep" },
      -- ui
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    },
  },
  {
    'folke/snacks.nvim',
    opts = function(_, opts)
      return vim.tbl_deep_extend('force', opts or {}, {
        picker = {
          actions = {
            trouble_open = function(...)
              return require('trouble.sources.snacks').actions.trouble_open.action(...)
            end,
          },
          win = {
            input = {
              keys = {
                ['<a-t>'] = {
                  'trouble_open',
                  mode = { 'n', 'i' },
                },
              },
            },
          },
        },
      })
    end,
  },
  {
    'folke/snacks.nvim',
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ['<a-s>'] = { 'flash', mode = { 'n', 'i' } },
              ['s'] = { 'flash' },
            },
          },
        },
        actions = {
          flash = function(picker)
            require('flash').jump {
              pattern = '^',
              label = { after = { 0, 0 } },
              search = {
                mode = 'search',
                exclude = {
                  function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'snacks_picker_list'
                  end,
                },
              },
              action = function(match)
                local idx = picker.list:row2idx(match.pos[1])
                picker.list:_move(idx, true, true)
              end,
            }
          end,
        },
      },
    },
  },
}
