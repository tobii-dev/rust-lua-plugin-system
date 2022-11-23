local M = {}

--- We can share stuff between plugins like this:
local lib = require("plugins.lib.lib")


M.info = {
	name = "TestLib",
	version = 0.1
}


function M.init()
	print(">> plugins/test_lib/test_lib.lua:init()")

	--- Proof we can share stuff between plugins:
	-- NOTE: plugins/lib/lib.lua must load before this.
	-- (Because it is responsible for initializing lib.shared_stuff)
	if not lib.shared_stuff then
		return false
	end

	local s = lib.shared_stuff.shared_string
	print(">> plugins/test/test.lua:lib.shared_stuff.shared_string = \""..s.."\"")

	return true
end


return M
