local M = {}
local user_lspconfig = require("user-lspconfig")
function M.setup()
  user_lspconfig.setup()
end
return M
