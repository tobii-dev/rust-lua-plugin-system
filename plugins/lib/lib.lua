--- Plugin to prove that plugins can also share stuff with other plugins.
local M = {}

M.info = {
	name = "LibPlugin",
	version = 0.1
}

---@class shared_stuff
---@field shared_num number A shared number
---@field shared_string string A shared string
---@field shared_bool boolean A shared boolean


function M.init()
	print(">> plugins/lib_plugin/lib.lua: init()")

	---@type shared_stuff
	M.shared_stuff = {
		shared_num = 1337,
		shared_string = "abc",
		shared_bool = true,
	}

	return true
end

return M
