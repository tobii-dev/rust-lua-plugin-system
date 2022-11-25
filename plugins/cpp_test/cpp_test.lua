---This is just here for easy importing and LSP stuff
local M = {}

---@param n number
---@return boolean T always `true`
function M.hello(n) end

local LIB = require("plugins.cpp_test.lib-cpp_test")
if LIB then return LIB end

return M --unreachable
