lib-cpp_test.so: src/main.cpp
	clang++ -o lib-cpp_test.so -shared -fPIC src/main.cpp -llua5.1

test: lib-cpp_test.so
	lua5.1 -e 'local lib = require("lib-cpp_test"); print(lib.init()); print(lib.hello(1))'

clean:
	rm -f lib-cpp_test.so
