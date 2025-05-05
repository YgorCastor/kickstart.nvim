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

return M
