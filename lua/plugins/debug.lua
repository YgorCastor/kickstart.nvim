return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      'rcarriga/nvim-dap-ui',
    },
    keys = {
      -- Debug keymaps
      { '<leader>db', '<cmd>DapToggleBreakpoint<cr>', desc = 'Toggle Breakpoint' },
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Conditional Breakpoint',
      },
      {
        '<leader>dl',
        function()
          require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
        end,
        desc = 'Logpoint',
      },
      { '<leader>dc', '<cmd>DapContinue<cr>', desc = 'Continue' },
      { '<leader>di', '<cmd>DapStepInto<cr>', desc = 'Step Into' },
      { '<leader>do', '<cmd>DapStepOver<cr>', desc = 'Step Over' },
      { '<leader>dO', '<cmd>DapStepOut<cr>', desc = 'Step Out' },
      { '<leader>dr', '<cmd>DapToggleRepl<cr>', desc = 'Toggle REPL' },
      { '<leader>dq', '<cmd>DapTerminate<cr>', desc = 'Terminate' },
      {
        '<leader>dR',
        function()
          require('dap').restart()
        end,
        desc = 'Restart',
      },

      -- DAP UI specific keymaps
      {
        '<leader>du',
        function()
          require('dapui').toggle()
        end,
        desc = 'Toggle UI',
      },
      {
        '<leader>de',
        function()
          require('dapui').eval()
        end,
        desc = 'Evaluate Expression',
        mode = { 'n', 'v' },
      },
      {
        '<leader>df',
        function()
          require('dapui').float_element()
        end,
        desc = 'Float Element',
      },
      {
        '<leader>ds',
        function()
          require('dapui').float_element 'scopes'
        end,
        desc = 'Float Scopes',
      },
      {
        '<leader>dt',
        function()
          require('dapui').float_element 'stacks'
        end,
        desc = 'Float Threads/Stacks',
      },
      {
        '<leader>dw',
        function()
          require('dapui').float_element 'watches'
        end,
        desc = 'Float Watches',
      },
      {
        '<leader>dh',
        function()
          require('dapui').float_element 'hover'
        end,
        desc = 'Float Hover',
      },
    },
    config = function()
      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '🟡', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = 'DapLogPoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '▶️', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '⭕', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })

      -- Set up DAP commands with user-friendly names
      vim.api.nvim_create_user_command('DapToggleBreakpoint', function()
        require('dap').toggle_breakpoint()
      end, {})
      vim.api.nvim_create_user_command('DapContinue', function()
        require('dap').continue()
      end, {})
      vim.api.nvim_create_user_command('DapStepInto', function()
        require('dap').step_into()
      end, {})
      vim.api.nvim_create_user_command('DapStepOver', function()
        require('dap').step_over()
      end, {})
      vim.api.nvim_create_user_command('DapStepOut', function()
        require('dap').step_out()
      end, {})
      vim.api.nvim_create_user_command('DapToggleRepl', function()
        require('dap').repl.toggle()
      end, {})
      vim.api.nvim_create_user_command('DapTerminate', function()
        require('dap').terminate()
      end, {})
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'

      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '→' },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        -- Expand lines larger than the window
        expand_lines = true,
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position.
        -- Elements are the elements shown in the layout (in order).
        layouts = {
          {
            elements = {
              -- Elements can be strings or table with id and size keys.
              { id = 'scopes', size = 0.25 },
              'breakpoints',
              'stacks',
              'watches',
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              'repl',
              'console',
            },
            size = 0.25,
            position = 'bottom',
          },
        },
        controls = {
          -- Requires Neovim nightly (or 0.8 when released)
          enabled = true,
          -- Display controls in this element
          element = 'repl',
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = '⏪',
            run_last = '⟲',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          border = 'single', -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
        },
      }

      -- Automatically open UI when debugging starts
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}
