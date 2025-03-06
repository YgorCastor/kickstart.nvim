return {
  { 'kdheepak/monochrome.nvim', lazy = true, priority = 1001 },
  {
    '0xstepit/flow.nvim',
    lazy = true,
    priority = 1000,
    opts = {},
  },
  { 'savq/melange-nvim' },
  { 'phha/zenburn.nvim' },
  {
    'killitar/obscure.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'slugbyte/lackluster.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'Tsuzat/NeoSolarized.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('NeoSolarized').setup {
        style = 'light',
        transparent = false,
      }
    end,
  },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  {
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      require('themery').setup {
        themes = {
          'catppuccin',
          'flow',
          'monochrome',
          'melange',
          'zenburn',
          'obscure',
          'bamboo',
          'lackluster',
          'NeoSolarized',
        },
      }
    end,
  },
}
