return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      {
        '<leader>e',
        function()
          local window_exists = false
          for _, win in pairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local buf_name = vim.api.nvim_buf_get_name(buf)
            if buf_name:match 'neo%-tree filesystem' then
              window_exists = true
              break
            end
          end

          if window_exists then
            vim.cmd 'Neotree close'
          else
            vim.cmd 'Neotree reveal'
          end
        end,
        desc = 'NeoTree toggle',
        silent = true,
      },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    },
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Auto Close Pairs
      require('mini.pairs').setup()

      -- Indent Scope Visualizer
      require('mini.indentscope').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Add a custom section for the clock
      local default_section_fileinfo = statusline.section_fileinfo
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_fileinfo = function(args)
        local fileinfo = default_section_fileinfo(args)
        local time = os.date '%H:%M'
        return fileinfo .. ' | ' .. time
      end
    end,
  },
  {
    's1n7ax/nvim-terminal',
    lazy = true,
    event = 'VeryLazy',
    config = function()
      vim.o.hidden = true
      require('nvim-terminal').setup {
        toggle_keymap = '<C-n>t',
      }
    end,
  },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle Neotest Summary',
      },
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-elixir',
        },
      }
    end,
  },
  {
    'olimorris/persisted.nvim',
    lazy = false, -- make sure the plugin is always loaded at startup
    keys = {
      { '<leader>ps', '<cmd>Telescope persisted<cr>', desc = 'Sessions' },
    },
    config = function()
      require('persisted').setup {
        save_dir = vim.fn.expand(vim.fn.stdpath 'data' .. '/sessions/'),
        use_git_branch = true,
        autoload = false,
        follow_cwd = true,
        telescope = {
          mappings = {
            copy_session = '<C-c>',
            change_branch = '<C-b>',
            delete_session = '<C-d>',
          },
          icons = {
            selected = ' ',
            dir = '  ',
            branch = ' ',
          },
        },
      }

      -- Load the telescope extension
      require('telescope').load_extension 'persisted'
    end,
  },
  {
    'sindrets/diffview.nvim',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>dh', '<cmd>DiffviewFileHistory<cr>', desc = 'File History' },
    },
    opts = {
      view = {
        default = {
          layout = 'diff2_horizontal',
        },
        merge_tool = {
          layout = 'diff3_horizontal',
          disable_diagnostics = true,
        },
        file_history = {
          layout = 'diff2_horizontal',
        },
      },
    },
  },
  {
    'mistricky/codesnap.nvim',
    build = 'make',
    lazy = true,
    config = function()
      require('codesnap').setup {
        has_breadcrumbs = false,
        watermark = '',
        save_path = '~/Pictures',
      }
    end,
  },
  {
    'VidocqH/lsp-lens.nvim',
    config = function()
      require('lsp-lens').setup {}
    end,
  },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      animate = { enabled = true },
      dashboard = { enabled = true },
      input = { enabled = true },
    },
  },
  {
    'folke/snacks.nvim',
    ---@type snacks.Config
    opts = {

      dashboard = {
        preset = {
          header = [[
    .---.
   / 6 6 \ 
                            (   Y   )    .---------------------.
                             \  ~  /    |     CastorVim >_     |
                             /     \    |  [   ]         [   ] |
                          ( (| |) )   '---------------------'
 \_|_|_/
 | |
  /   \
 /     \
  /       \
 (_________)]],
        },
        sections = {
          { section = 'header' },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          { section = 'startup' },
        },
      },
    },
  },
}
