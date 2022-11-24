--- This plugin:
local M = {}


--- Optional: we can use this SHARED API to call game functions.
local game_api = require("game")


--- Info about this plugin:
M.info = {
	--- Plugin name:
	name = "Test",
	--- Plugin version:
	version = 0.1
}

--- Required init() function.
-- Called when loader.lua loads all the plugins.
-- Plugin load order is in plugins/plugins.lua
function M.init()
	print(">> plugins/test/test.lua:init()")
	return true
end

--- Local var to prove that plugins can have their own state and keep track of it...
---@type number
local t = 1

-- This is called when:
-- -> Rust: src/main.rs: <LuaFunction> lua_api.[...].fn_hook.call() calls ->
-- -> Lua: loader.lua:fn_hook(), which calls the hook() function on every loaded plugin.
function M.hook(v)
	-- Update this (local) plugin state
	t = t + v
	print(">> plugins/test/test.lua: hook("..t..")")
	-- We can call stuff from game.lua
	local x = game_api.fn_hello(v)
	print(">> plugins/test/test.lua:hook() game_api.fn_hello() returns "..tostring(x))

	return true
end

--- Return the plugin
return M
