return {
  { 'kdheepak/monochrome.nvim', lazy = false, priority = 1001 },
  {
    '0xstepit/flow.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'wtfox/jellybeans.nvim',
    lazy = false,
    priority = 1000,
  },
  { 'savq/melange-nvim', lazy = false, priority = 1000 },
  { 'phha/zenburn.nvim', lazy = false, priority = 1000 },
  {
    'killitar/obscure.nvim',
    lazy = false,
    priority = 1000,
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
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'zaldih/themery.nvim',
    lazy = false,
    cmd = { 'Themery' },
    config = function()
      require('themery').setup {
        themes = {
          'catppuccin',
          'flow',
          'jellybeans',
          'monochrome',
          'melange',
          'zenburn',
          'obscure',
          'bamboo',
          'lackluster',
          'NeoSolarized',
          'kanso',
        },
      }
    end,
  },
}
