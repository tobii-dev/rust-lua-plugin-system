local M = {}

---@param s string
function M.hello(s) end


local LIB = require("plugins.rust_test.lib-rust_test")
if LIB then return LIB end

return M --- unreachable

