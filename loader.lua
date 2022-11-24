--- This module is responsible for loading the plugins in plugins/plugins.lua
local M = require("game")


--TODO: this should really be a function...
for _,plugin in pairs(require("plugins.plugins")) do
	if plugin.info and plugin.init then
		print(">> LOADING: "..plugin.info.name.."@"..plugin.info.version)
		local ok, rs = pcall(plugin.init)
		if ok then
			if rs then
				M.loaded_plugins[#M.loaded_plugins+1] = plugin
				print("\t...OK!")
			else
				print("\t...NOT LOADED: init() returned false")
			end
		else
			print("\t...ERROR: "..rs)
		end
		print()
	end
end


--TODO: Move Lua callbacks somewhere more sane (hooks.lua?)

--- Responsible for doing every plugin hook() callback
---@param v number IDK some number to print, here to prove we can pass values around...
---@return boolean update IDK returns `true`
function M.fn_hook(v)
	for _,plugin in pairs(M.loaded_plugins) do
		--TODO: Be more explicit about how callbacks are done?
		if plugin.hook then
			local ok, rs = pcall(plugin.hook, v)
			if ok then
				print(">> fn_hook() - HOOK: "..plugin.info.name.." = "..tostring(rs))
			else
				print(">> fn_hook() - ERROR at ["..plugin.info.name.."] "..tostring(rs))
			end
		end
	end
	return true
end


--- Return the game API with the plugins loaded
return M
