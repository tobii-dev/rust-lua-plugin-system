local M = {}

M.info = {
	name = "Example",
	version = 0.1
}

function M.init()
	print(">> plugins/example/example.lua: init()")
	return true
end

return M
