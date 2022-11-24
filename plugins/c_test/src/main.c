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


static const struct luaL_Reg functions[] = {
	{"hello", hello},
	{"init", init},
	{NULL, NULL},
};


int luaopen_c_test(lua_State * L) {
	luaL_register(L, "M", functions);
	luaL_dostring(L, "M.info = { name = \"C\", version = 0.1 }"); //TODO: build info table in C
	return 1;
}
