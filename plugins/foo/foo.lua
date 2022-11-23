local M = {}

M.info = {
	name = "Foo",
	version = 0.1
}

function M.init()
	print("FOO!")
	return true
end

return M
