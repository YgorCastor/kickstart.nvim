-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`

local function augroup(name)
  return vim.api.nvim_create_augroup('castorvim_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup 'highlight_yank',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  callback = function()
    if require('nvim-treesitter.parsers').has_parser() then
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    else
      vim.opt.foldmethod = 'syntax'
    end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup 'resize_splits',
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup 'checktime',
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
})

-- Notification when file changes
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  desc = 'Notify when file is changed externally',
  group = vim.api.nvim_create_augroup('file_change_notification', { clear = true }),
  callback = function()
    vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.WARN)
  end,
})

-- Detach LSPs if they are not attached to any buffer
vim.api.nvim_create_autocmd('LspDetach', {
  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local current_buf = args.buf

    if client then
      local clients = vim.lsp.get_clients { id = client_id }
      local count = 0

      if clients and #clients > 0 then
        local remaining_client = clients[1]

        if remaining_client.attached_buffers then
          for buf_id in pairs(remaining_client.attached_buffers) do
            if buf_id ~= current_buf then
              count = count + 1
            end
          end
        end
      end

      if count == 0 then
        client:stop()
      end
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'lazygit',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup 'json_conceal',
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup 'auto_create_dir',
  callback = function(event)
    if event.match:match '^%w%w+:[\\/][\\/]' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})
