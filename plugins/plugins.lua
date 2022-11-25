return {
	-- require("plugins.example.example"),
	require("plugins.test.test"),
	-- require("plugins.foo.foo"),

	-- require("plugins.lib.lib"), -- must load before test_lib
	-- require("plugins.test_lib.test_lib"), -- must load after lib

	-- require("plugins.rust_test.rust_test"), -- written in Rust
	-- require("plugins.c_test.c_test"), -- written in C
	-- require("plugins.cpp_test.cpp_test"), -- written in C++
}
