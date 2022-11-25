#include <iostream>
#include <lua5.1/lua.hpp>

int hello(lua_State * L) {
	double n = luaL_checknumber(L, 1);
	std::cout << "Hello: " << n << std::endl;
	lua_pushboolean(L, true);
	return 1;
}

int init(lua_State * L) {
	std::cout << ">> plugins/cpp_test/src/main.c:init()" << std::endl;
	lua_pushboolean(L, true);
	return 1;
}

extern "C" int luaopen_cpp_test(lua_State * L) {
	lua_newtable(L); // local M = {}

	lua_newtable(L); // info = {}
	lua_pushstring(L, "Cpp");
	lua_setfield(L, -2, "name"); // info.name = "Cpp"
	lua_pushnumber(L, 0.1);
	lua_setfield(L, -2, "version"); // info.version = 0.1

	lua_setfield(L, -2, "info"); // M.info = info

	lua_pushcfunction(L, init);
	lua_setfield(L, -2, "init"); //M.init = init

	lua_pushcfunction(L, hello);
	lua_setfield(L, -2, "hello"); //M.hello = hello

	return 1; // return M
}
