lib-c_test.so: src/main.c
	$(CC) -o lib-c_test.so -shared -fpic src/main.c -llua5.1

test: lib-c_test.so
	lua5.1 -e 'local lib = require("lib-c_test"); print(lib.hello(1))'

clean:
	rm -f lib-c_test.so
