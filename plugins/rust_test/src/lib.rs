use mlua::prelude::*;

fn hello(_: &Lua, name: String) -> LuaResult<()> {
    println!("hello, {}!", name);
    Ok(())
}

fn init(_: &Lua, _: ()) -> LuaResult<bool> {
    println!("plugins/rust_test/src/lib.rs:init()");
    Ok(true)
}

#[mlua::lua_module]
fn rust_test(lua: &Lua) -> LuaResult<LuaTable> {
    let exports = lua.create_table()?;

    let info = lua.create_table()?;
    info.set("name", "RustTest")?;
    info.set("version", 0.1)?;
    exports.set("info", info)?;

    exports.set("init", lua.create_function(init)?)?;
    exports.set("hello", lua.create_function(hello)?)?;
    Ok(exports)
}
