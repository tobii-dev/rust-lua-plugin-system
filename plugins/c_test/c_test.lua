local M = {}

---@param n number Print this number
---@return boolean T Always returns `true`
function M.hello(n) end

local LIB = require("plugins.c_test.lib-c_test")
if LIB then return LIB end

return M --unreachable
