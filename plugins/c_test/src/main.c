#include <stdio.h>
#include <stdbool.h>

#include <lua5.1/lua.h>
#include <lua5.1/lauxlib.h>

int hello(lua_State * L) {
	double n = luaL_checknumber(L, 1);
	printf(">> Hello: %f\n", n);
	lua_pushboolean(L, true);
	return 1;
}

int init(lua_State * L) {
	printf(">> plugins/c_test/src/main.c:init()\n");
	lua_pushboolean(L, true);
	return 1;
}

int luaopen_c_test(lua_State * L) {
	lua_newtable(L); // local M = {}

	lua_newtable(L); // info = {}
	lua_pushstring(L, "C");
	lua_setfield(L, -2, "name"); // info.name = "C"
	lua_pushnumber(L, 0.1);
	lua_setfield(L, -2, "version"); // info.version = 0.1

	lua_setfield(L, -2, "info"); // M.info = info

	lua_pushcfunction(L, init);
	lua_setfield(L, -2, "init"); //M.init = init

	lua_pushcfunction(L, hello);
	lua_setfield(L, -2, "hello"); //M.hello = hello

	return 1; // return M
}
