return {
	require("plugins.example.example"),
	require("plugins.test.test"),
	-- require("plugins.foo.foo"),

	-- require("plugins.lib.lib"), -- must load before test_lib
	-- require("plugins.test_lib.test_lib"), -- must load after lib

	-- require("plugins.rust_test.rust_test"),
}
