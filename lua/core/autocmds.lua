-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  callback = function()
    -- check if treesitter has parser
    if require('nvim-treesitter.parsers').has_parser() then
      -- use treesitter folding
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    else
      -- use alternative foldmethod
      vim.opt.foldmethod = 'syntax'
    end
  end,
})

-- Auto-reload files when they change on disk
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  desc = 'Check if files have been modified outside of Neovim',
  group = vim.api.nvim_create_augroup('checktime', { clear = true }),
  callback = function()
    if vim.fn.mode() ~= 'c' then
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
