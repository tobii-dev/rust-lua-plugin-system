local M = require("game")


---Loads plugins from plugins/plugins.lua
local function load_plugins()
	local loaded_plugins = {}
	local plugins_ok, plugins_rs = pcall(require, "plugins.plugins")
	if not plugins_ok then
		print(plugins_rs)
		return {}
	end
	for k,plugin in pairs(plugins_rs) do
		if not plugin.info then
			print("\t...ERROR: plugins["..k.."] no plugin.info {} table.")
		elseif not plugin.init then
			print("\t...ERROR: plugins["..k.."] no plugin.init() function.")
		else
			print(">> LOADING: "..plugin.info.name.."@"..plugin.info.version)
			local ok, rs = pcall(plugin.init)
			if not ok then
				print("\t...ERROR: "..rs)
			elseif not rs then
				print("\t...NOT LOADED: init() returned false")
			else
				loaded_plugins[#loaded_plugins+1] = plugin
				print("\t...OK!")
			end
		end
		print()
	end
	return loaded_plugins
end

M.loaded_plugins = load_plugins()


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
