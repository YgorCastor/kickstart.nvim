local M = {}

function M.get_config(server)
  local configs = require 'lspconfig.configs'
  return rawget(configs, server)
end

function M.get_raw_config(server)
  local ok, ret = pcall(require, 'lspconfig.configs.' .. server)
  if ok then
    return ret
  end
  return require('lspconfig.server_configurations.' .. server)
end

function M.is_enabled(server)
  local c = M.get_config(server)
  return c and c.enabled ~= false
end

---@param on_attach fun(client:vim.lsp.Client, buffer)
---@param name? string
function M.on_attach(on_attach, name)
  return vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (not name or client.name == name) then
        return on_attach(client, buffer)
      end
    end,
  })
end

return M
