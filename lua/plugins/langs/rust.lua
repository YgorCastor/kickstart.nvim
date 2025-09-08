return {
  {
    'Saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'rust', 'ron' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        bacon_ls = {
          init_options = {
            updateOnSave = true,
            updateOnSaveWaitMillis = 1000,
          },
        },
        rust_analyzer = {
          diagnostics = {
            enable = false,
          },
          checkOnSave = {
            enable = false,
          },
        },
      },
    },
  },
}
