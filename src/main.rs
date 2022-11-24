use std::rc::Rc;
use std::sync::Mutex;

use mlua::{chunk, prelude::*};

/// Prove we can access global state stuff
#[derive(Debug)]
struct GlobalState {
    state: usize, // Represents something about the game state.
}

impl GlobalState {
    /// Dummy function to update the game state.
    fn fn_update(&mut self, var: usize) -> bool {
        self.state += var;
        println!("## fn_update(): state = {}", self.state);
        return self.state % 2 == 0; // true if the state is even
    }
}

fn main() {
    // the GameState
    // Rc(Mutex()) because multiple owners (we pass it around to closures that are called from Lua)
    //TODO: Figure out if we can do this with RwLock or RefCell?
    let gs = Rc::new(Mutex::new(GlobalState { state: 0 }));

    // Like a lua_State in C
    // let lua_vm = Lua::new();
    let lua_vm = unsafe { Lua::unsafe_new() }; // Allow loading custom modules.

    // Fancy rust macro: allows writing Lua code in Rust
    let init_code = chunk! {
        print(">> Hi")
        api = require("loader")
    };
    lua_vm.load(init_code).exec().unwrap(); // Load the plugins

    // api defined in game.lua:
    let lua_api: LuaTable = lua_vm.globals().get("api").unwrap(); // "api" is a global variable

    // prove we can call functions in Lua (game.lua) from Rust:
    let fn_hello: LuaFunction = lua_api.get("fn_hello").unwrap();
    let fn_hello_result: bool = fn_hello.call(10).unwrap();
    dbg!(fn_hello_result);

    // Create Rust function that we can call from Lua as fn_update()
    {
        let gs = Rc::clone(&gs);

        // Represents a function callable from Lua:
        // [ v: usize ] -> take (unsigned) number
        // [ LuaResult<bool> ] -> return a boolean
        let fn_update_closure = move |_l: &Lua, v: usize| -> LuaResult<bool> {
            println!("# Hi from fn_update()!");
            let mut gs = gs.lock().unwrap(); // From here see the GlobalState
            Ok(gs.fn_update(v)) // And even modify it!
        };
        let fn_update: LuaFunction = lua_vm.create_function(fn_update_closure).unwrap();
        lua_api.set("fn_update", fn_update).unwrap(); // add this function to the "api" table
    }

    // Same as above, but a bit more consise: fn_anon()
    {
        let gs = Rc::clone(&gs);
        let fn_anon: LuaFunction = lua_vm
            .create_function(move |_l: &Lua, v: usize| -> LuaResult<bool> {
                println!("# Hi from fn_anon()!");
                let mut gs = gs.lock().unwrap();
                let x = gs.state;
                Ok(gs.fn_update(x.saturating_sub(v))) // IDK, something different?
            })
            .unwrap();
        lua_api.set("fn_anon", fn_anon).unwrap(); // add to api
    }

    // Print state
    {
        let mut gs = gs.lock().unwrap();
        dbg!(&gs);
        dbg!(gs.fn_update(10));
    }

    {
        // Call Rust->Lua->Rust...
        {
            let fn_update_result = lua_api
                .get::<_, LuaFunction>("fn_update")
                .unwrap()
                .call::<usize, bool>(10)
                .unwrap();
            dbg!(fn_update_result);
        }

        {
            let fn_anon_result = lua_api
                .get::<_, LuaFunction>("fn_anon")
                .unwrap()
                .call::<usize, bool>(10)
                .unwrap();
            dbg!(fn_anon_result);
        }
    }

    // Pretend hook
    {
        println!();
        let fn_hook: LuaFunction = lua_api.get("fn_hook").unwrap();
        let fn_hook_result: bool = fn_hook.call(1 as usize).unwrap();
        dbg!(&fn_hook_result);
    }
    // Pretend hook
    {
        println!();
        let fn_hook: LuaFunction = lua_api.get("fn_hook").unwrap();
        let fn_hook_result2: bool = fn_hook.call(1 as usize).unwrap();
        dbg!(&fn_hook_result2);
    }
}
