# Rust Lua Plugin System

## Getting started

You need Rust \& Cargo installed.
You might also need to install a lua5.1 (dev) package for your system.
```bash
git clone https://gitlab.com/tobii-dev/rust-lua-plugin-system.git
cd rust-lua-plugin-system
cargo run
```

## Description
This is meant to be a proof of concept on how to manage lua plugin system in Rust.
The Rust app has a state: we pretend this represents the state of a game.

### Game hooks
When the app state changes, we can keep track with hooks.
Lua plugins can "subscribe" to these hooks and run their own spooky Lua code when they happen.

### Game API
We can modify the state of the game and call Rust functions from the Lua plugins.
To expose these functions (in a dev friendly way), a plugin can import a Lua API, that calls Rust funcions.


## Adding a custom plugin
Lets just do an example: adding a plugin called "foo" that says "FOO!"" and maybe does some other stuff...
1. Create a directory for this plugin, like for example: `plugins/foo/`
2. Write the basics: `plugins/foo/foo.lua`
    2.1 Every plugin should have a name and version:
	```lua
	-- This M thing represents the the Lua module.
	-- Everything in there will be passed to the plugin loader.
	local M = {}
	
	-- Every plugin should have an info table.
	M.info = {
		name = "Foo", -- A very original name for our plugin
		version = 0.1 -- The version.
	}
	
    return M -- Return: this plugin :D
	```
	2.2 Like this, our plugin would not load. To load plugins, the plugin loader calls an `init()` function for every plugin. Lets add this function:
	```lua
	-- This M thing represents the the Lua module:
	--  Everything in there will be passed to the plugin loader.
	local M = {}
	
	-- Every plugin should have an info table.
	M.info = {
		name = "Foo", -- A very original name for our plugin
		version = 0.1 -- The version.
	}
	
	-- This will be called when the plugin loads
	function M.init()
		print("FOO!") -- Do the thing :D
		return true -- true means we loaded correctly
	end

	return M -- Return this plugin :D
	```
	2.3 But we are still not done! To tell the loader to load this new plugin, add this new plugin to `plugins/plugins.lua`. That is where the loader looks for plugins.
	```lua
	return {
		require("plugins.example.example"),
		require("plugins.test.test"),
		require("plugins.foo.foo"), -- This is what points the loader to plugins/foo/foo.lua
	}
	```
	2.4 When you run the app now, it should say "FOO!" when the plugins load.
	```
	...
		>> LOADING: Foo@0.1
		FOO!
				...OK!
	...
	```
	2.5 Well it loaded and it said "FOO!"... But can we do more? Yes!
	Have a look at the other plugins in `plugins/` for examples of using hooks, calling the API, etc.

***

## TODO

- [X] Rust example.
- [X] Plugin loader fully in Lua.
- [X] Create and load plugins in lua.
- [X] Call Lua hook() from Rust code.
- [X] Call Rust fn_() from Lua plugin.
- [X] Call "API" example from Lua.
- [X] Create and load plugins written in Rust
- [X] Create and load plugins written in C
- [X] Create and load plugins written in C++
- [ ] Pre/Post hook stuff.
- [ ] Advanced examples.

***

## Roadmap
//

## Contributing
//

## Authors and acknowledgment
//

## License
//

## Project status
//
