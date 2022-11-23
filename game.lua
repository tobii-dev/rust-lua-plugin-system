--- Declarations for the SHARED Lua API that plugins can use:
local M = {}


---List of plugins that successfully loaded
M.loaded_plugins = {}


-- === "Native" functions: === --

---[Rust] -- Declared here so LSP knows that it exists...
---@param v number Update global state with v
---@return boolean B `true` if `state.state` was even after updating
function M.fn_update(v) end

---[Rust] -- Declared here so LSP knows that it exists...
---@param v number
---@return boolean B
function M.fn_anon(v) end



-- === "Pure Lua" functions: === --

---Say hello!
---@param v number
---@return boolean B Always returns `true` :D
function M.fn_hello(v)
	print(">> Hello! from game.lua:fn_hello() { v="..v.." }")
	return true
end


---@class info
---@field name string Name
---@field version number Version

return M
