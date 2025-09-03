return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        'nvim-dap-ui',
      },
    },
  },
  {

    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'stylua',
        'shfmt',
      },
    },
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 1000,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters = {
        mix = {
          command = 'mix',
          args = { 'format', '-' },
          cwd = function(ctx)
            -- Find the root directory containing mix.exs
            local file = vim.fn.findfile('mix.exs', vim.fn.expand '%:p:h' .. ';')
            if file ~= '' then
              return vim.fn.fnamemodify(file, ':h')
            end
            return nil
          end,
          require_cwd = true,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },
  {
    'zeioth/none-ls-autoload.nvim',
    event = 'BufEnter',
    dependencies = { 'williamboman/mason.nvim', 'nvimtools/none-ls.nvim' },
    opts = {},
  },
  {
    'nvimtools/none-ls.nvim',
    opts = function(_, opts)
      opts.sources = vim.list_extend(opts.sources or {}, {})
    end,
  },
  { -- Autocompletion
    'saghen/blink.cmp',
    version = '*', -- use a release tag to download pre-built binaries
    dependencies = {
      'rafamadriz/friendly-snippets', -- optional: provides snippets for the snippet source
      'fang2hou/blink-copilot',
    },
    opts = {
      keymap = { preset = 'enter' },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = {
          draw = function(opts)
            if opts.item and opts.item.documentation then
              local out = require('pretty_hover.parser').parse(opts.item.documentation.value)
              opts.item.documentation.value = out:string()
            end

            opts.default_implementation(opts)
          end,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
      },
      sources = {
        default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            module = 'lazydev',
            score_offset = 100, -- prioritize lazydev completions
          },
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
  { 'williamboman/mason-lspconfig.nvim', config = function() end },
  {
    'neovim/nvim-lspconfig',
    event = 'LazyFile',
    dependencies = {
      'mason.nvim',
      { 'williamboman/mason-lspconfig.nvim', config = function() end },
    },
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = 'if_many',
            prefix = '●',
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = '',
              [vim.diagnostic.severity.WARN] = '',
              [vim.diagnostic.severity.HINT] = '',
              [vim.diagnostic.severity.INFO] = '',
            },
          },
        },
        inlay_hints = {
          enabled = true,
        },
        codelens = {
          enabled = false,
        },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        servers = {
          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = 'Replace',
                },
                doc = {
                  privateName = { '^_' },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = 'Disable',
                  semicolon = 'Disable',
                  arrayIndex = 'Disable',
                },
              },
            },
          },
        },
        setup = {},
      }
      return ret
    end,
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', function()
            Snacks.picker.lsp_definitions()
          end, '[G]oto [D]efinition')
          map('gr', function()
            Snacks.picker.lsp_references()
          end, '[G]oto [R]eferences')
          map('gI', function()
            Snacks.picker.lsp_implementations()
          end, '[G]oto [I]mplementation')
          map('<leader>D', function()
            Snacks.picker.lsp_type_definitions()
          end, 'Type [D]efinition')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

      local servers = opts.servers

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then
            return
          end
        end
        require('lspconfig')[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, 'mason-lspconfig')
      local all_mslp_servers = {}

      if have_mason then
        all_mslp_servers = vim.tbl_keys(require('mason-lspconfig').get_mappings().lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]

      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup {
          ensure_installed = vim.tbl_deep_extend('force', ensure_installed, Helpers.opts('mason-lspconfig.nvim').ensure_installed or {}),
          automatic_installation = false,
          handlers = { setup },
        }
      end
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    opts = {
      modes = {
        lsp = {
          win = { position = 'right' },
        },
      },
    },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').prev { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Previous Trouble/Quickfix Item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Next Trouble/Quickfix Item',
      },
    },
  },
  {
    'Fildo7525/pretty_hover',
    event = 'LspAttach',
    keys = {
      {
        '<leader>hf',
        function()
          require('pretty_hover').hover()
        end,
        desc = 'Hover Functon Documentation',
      },
    },
    opts = {},
  },
}
