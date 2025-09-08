return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'ninja', 'rst' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        pyright = {},
        ruff = {},
      },
    },
  },
  {
    'nvim-neotest/neotest-python',
  },
}
