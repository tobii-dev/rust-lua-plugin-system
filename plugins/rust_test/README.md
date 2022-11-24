## This is a plugin made in Rust

```bash
cargo build --release
cp target/release/librust_test.<?> lib-rust_test.<?>
```
Extra steps might be needed to link.

TODO: Makefile or .bat for windows.

Must generate something that can be used in `plugins/plugins.lua` as:
```lua
require("plugins.rust_test.rust_test")
```

To load it, the lua VM must allow loading custom modules. (Unsafe in mlua)
